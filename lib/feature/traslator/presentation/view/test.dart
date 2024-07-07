import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;


class VideoStreamingPage extends StatefulWidget {



  @override
  _VideoStreamingPageState createState() => _VideoStreamingPageState();
}

class _VideoStreamingPageState extends State<VideoStreamingPage> {
  late TextEditingController tex = TextEditingController();
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
    controller.dispose();
    _stopStreaming();
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
        _sendFrameToServer('http://192.168.0.114:5000', cameraImage);
        _getLabelsFromServer();
      }
    });
  }

  void _connectToServer() {
    if (isStreaming) {
      setState(() {
        isStreaming = false;
      });
      _stopStreaming();
    } else {
      final String ip = 'ip';
      if (ip.isEmpty) {
        return;
      }

      setState(() {
        isStreaming = true;
      });
      serverUrl = 'http://192.168.0.114:5000';
      _startStreaming();
    }
  }

  Future<void> _sendFrameToServer(
      String serverUrl, CameraImage cameraImage) async {
    try {
      final Uint8List bytes = cameraImage.planes[0].bytes;
      final response = await client.post(
        Uri.parse('http://192.168.0.114:5000/frame?mode=$mode'),
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
      final response = await client.get(Uri.parse('http://192.168.0.114:5000/labels'));
      if (response.statusCode == 200) {
        final labels = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          gestureLabel = labels['gesture'] ?? "None";
          signLabel = labels['sign'] ?? "None";

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
    const fetchInterval = Duration(milliseconds: 500);
    _timer = Timer.periodic(fetchInterval, (_) {
      // _fetchMessagesFromServer();
    });
  }

  Future<void> _fetchMessagesFromServer() async {
    try {
      final response = await client.get(Uri.parse('http://192.168.0.114:5000/receive'));
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
        Uri.parse('http://192.168.0.114:5000/send'),
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

  void _stopStreaming() {
    controller.stopImageStream();
    _timer?.cancel();
  }

  void switchCamera() async {
    if (cameras.length > 1) {
      controller = CameraController(
          currentCamera == 0 ? cameras[1] : cameras[0], ResolutionPreset.max);
      await controller.initialize();
      setState(() => currentCamera = currentCamera == 0 ? 1 : 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Streaming'),
      ),
      body:  _initialized ?Column(
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

                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _connectToServer,
                  child:
                  Text(isStreaming ? 'Stop Streaming' : 'Start Streaming'),
                ),
                Expanded(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    icon: Icon(
                      Icons.cameraswitch_outlined,
                      color: Color(0xff003248),
                    ),
                    onPressed: () {
                      switchCamera();
                    },
                  ),
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
      ): Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
