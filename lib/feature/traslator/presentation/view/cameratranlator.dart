import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class cameratranslator extends StatefulWidget {
  @override
  State<cameratranslator> createState() => _cameratranslatorState();
}

class _cameratranslatorState extends State<cameratranslator> {
  //late TextEditingController tex = TextEditingController();
  final TextEditingController _serverUrlController = TextEditingController();
  bool _initialized = false;
  int currentCamera = 0;
  late CameraController controller;
  late List<CameraDescription> cameras;
  int frameRate = 3;
  bool isStreaming = false;
  String? serverUrl;
  String gestureLabel = "None";
  String signLabel = "None";
  String mode = "gesture";
  String ip = '';
  String receivedMessage = "";
  http.Client client = http.Client();
  DateTime _lastFrameTime = DateTime.now();
  Timer? _timer;
  StreamSubscription<CameraImage>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _cameraSetUp().then((_) {
      if (cameras.isNotEmpty) {
        final frontCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
        );
        controller = CameraController(
          frontCamera,
          ResolutionPreset.medium,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _initialized = true;
          });
        });
        //_startReceivingMessages();
      }
    });
  }

  @override
  void dispose() {
    _stopStreaming();
    controller.dispose();
    client.close();
    super.dispose();
  }

  Future<void> _cameraSetUp() async {
    cameras = await availableCameras();
  }

  void _startStreaming() {
    controller.startImageStream((CameraImage cameraImage) async {
      final now = DateTime.now();
      final elapsed = now.difference(_lastFrameTime).inMilliseconds;
      if (elapsed >= (1000 ~/ frameRate)) {
        _lastFrameTime = now;
        _sendFrameToServer(serverUrl!, cameraImage);
        _getLabelsFromServer();
      }
    });
  }

  void _stopStreaming() {
    controller.stopImageStream();
    _timer?.cancel();
  }

  void _connectToServer() {
    if (isStreaming) {
      setState(() {
        isStreaming = false;
      });
      _stopStreaming();
    } else {
      final String ip = _serverUrlController.text.trim();
      if (ip.isEmpty) {
        return;
      }

      setState(() {
        isStreaming = true;
      });
      serverUrl = 'http://$ip:5000';
      _startStreaming();
    }
  }

  Future<void> _sendFrameToServer(
      String serverUrl, CameraImage cameraImage) async {
    try {
      final Uint8List bytes = cameraImage.planes[0].bytes;
      final response = await client.post(
        Uri.parse('$serverUrl/frame?mode=$mode'),
        headers: {'Content-Type': 'image/jpeg'},
        body: bytes,
      );
      if (response.statusCode != 200) {
        print('Failed to send frame: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending frame: $e');
    }
  }

  Future<void> _getLabelsFromServer() async {
    try {
      final response = await client.get(Uri.parse('$serverUrl/labels'));
      if (response.statusCode == 200) {
        final labels = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          gestureLabel = labels['gesture'] ?? "None";
          signLabel = labels['sign'] ?? "None";

          // Check for mode switching gestures
          if (gestureLabel == "thumbsup" && mode != "gesture") {
            mode = "gesture";
            frameRate = 3;
          } else if (gestureLabel == "victory" && mode != "sign") {
            mode = "sign";
            frameRate = 30;
          }
        });
      } else {
        print('Failed to get labels: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting labels: $e');
    }
  }

  void _startReceivingMessages() {
    const fetchInterval = Duration(milliseconds: 500); // Adjust as needed
    _timer = Timer.periodic(fetchInterval, (_) {
      _fetchMessagesFromServer();
    });
  }

  Future<void> _fetchMessagesFromServer() async {
    try {
      final response = await client.get(Uri.parse('$serverUrl/receive'));
      if (response.statusCode == 200) {
        final messages = json.decode(response.body) as List<dynamic>;
        if (messages.isNotEmpty) {
          setState(() {
            receivedMessage = messages.last.toString();
          });
        }
      } else {
        print('Failed to fetch messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  void _sendMessageToServer(String message) async {
    try {
      final response = await client.post(
        Uri.parse('$serverUrl/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': message}),
      );
      if (response.statusCode != 200) {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void _toggleMode() {
    setState(() {
      if (mode == "gesture") {
        mode = "sign";
        frameRate = 30;
      } else {
        mode = "gesture";
        frameRate = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: _initialized
          ? Stack(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  CameraPreview(controller),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gesture Label: $gestureLabel',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            'Sign Label: $signLabel',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Received Message: $receivedMessage',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _serverUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Server IP',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _connectToServer,
                  child:
                  Text(isStreaming ? 'Stop Streaming' : 'Start Streaming'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _toggleMode,
            child: Text(mode == "gesture"
                ? "Switch to Sign Mode"
                : "Switch to Gesture Mode"),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Send Message'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          receivedMessage = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          _sendMessageToServer(receivedMessage);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Send'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Send Message to Passenger'),
          ),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


//Container(
//height: 80,
//decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
//child: IconButton(
//onPressed: (){
//// isStreaming ? _stopStreaming() : _startStreaming();
//},
//iconSize: 50,
//padding: EdgeInsets.zero,
//constraints: const BoxConstraints(),
//icon:  isStreaming? Icon(Icons.rectangle, color: Color(0xff003248)):Icon(Icons.circle, color: Color(0xff003248)),
//),
//)