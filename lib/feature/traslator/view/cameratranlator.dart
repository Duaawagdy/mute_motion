import 'dart:async';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;
import 'package:socket_io_client/socket_io_client.dart';

class cameratranslator extends StatefulWidget{
  @override
  State<cameratranslator> createState() => _cameratranslatorState();
}

class _cameratranslatorState extends State<cameratranslator> {

  bool _initialized = true;
  int currentCamera = 0;
   CameraController? controller;
  late List<CameraDescription> cameras;
  bool isStreaming = false;
   StreamSubscription<CameraImage>? _streamSubscription;
  @override
  void initState() {
    _cameraSetUp();
    //initSocket();
    print('3');

    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  initconnection()async{
    Response response = await Dio().post("http://192.168.1.10:5000/upload", data:"hi");
  }
 /*Socket(){
    print('1');
    Map<String,dynamic> options={'trasports':['websocket'],'autoConnection':false};
    Io.Socket socket =Io.io('https://mutemotion.onrender.com/stream',options);
    print('2');

    socket.connected;
    print('4');
    socket.onConnect((_) {print('connected to server');});
    print('5');
  }*/
  Future<void> _startStreaming() async {
    if (controller?.value.isInitialized==null) {
      return;
    }

    setState(() {
      isStreaming = true;
      print(isStreaming);
    });


    _streamSubscription = controller?.startImageStream((CameraImage image) {
      // Convert the image to a byte array
      int? bytes = image.planes[0].bytesPerRow;
      int? bytes1 = image.planes[1].bytesPerPixel;
      int? bytes2 = image.planes[2].bytesPerPixel;
      //print('video format is ${bytes}');

      Uint8List pointerList =Uint8List(image.planes[0].bytes.length);
      Uint8List pointerList1=Uint8List(image.planes[1].bytes.length);
      Uint8List pointerList2=Uint8List(image.planes[2].bytes.length);
      pointerList.setRange(0, image.planes[0].bytes.length, image.planes[0].bytes);
      pointerList1.setRange(0, image.planes[1].bytes.length, image.planes[1].bytes);
      pointerList2.setRange(0, image.planes[2].bytes.length,image.planes[2].bytes);
      print("plane1 :${pointerList}");
     // print("plane2 :${pointerList1}");
      //print('bytes:${bytes}');
      initconnection();
      //print('bytes1:${bytes1}');
      //print('bytes:${bytes2}');
     // print("plane3 :${pointerList2}");
      // Send the byte array to the backend
      //_sendFrame(bytes);
    }) as StreamSubscription<CameraImage>;
  }



  Future<void> _stopStreaming() async {
    if (controller?.value.isInitialized==null) {
      return;
    }

    setState(() {
      isStreaming = false;
    });

    await _streamSubscription?.cancel();
    await controller?.stopImageStream();
  }
  getrgb(List bytes){

  }
  _cameraSetUp() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller?.initialize();
    setState(() => _initialized = false);
  }
  void switchCamera() async {
    if (cameras.length > 1) {
      controller = CameraController(
          currentCamera == 0 ? cameras[1] : cameras[0], ResolutionPreset.max);
      await controller?.initialize();
      setState(() => currentCamera = currentCamera == 0 ? 1 : 0);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      if (controller != null) CameraPreview(controller!),
      /*FloatingActionButton(
        heroTag: null,
        child: const Icon(
          Icons.cameraswitch_sharp,
          color: Colors.white,
        ),
        onPressed: () => switchCamera(),
      ),*/
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Color(0xff003248)),
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    icon: Icon(

                           Icons.switch_camera
                             ,
                        color: Colors.white70),
                    onPressed: () {
                      switchCamera();
                    },
                  )),
              Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white70),
                    child: IconButton(
                      onPressed: (){
                        isStreaming ? _stopStreaming() : _startStreaming();
                      },
                      iconSize: 50,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon:  isStreaming? Icon(Icons.rectangle, color: Color(0xff003248)):Icon(Icons.circle, color: Color(0xff003248)),
                    ),
                  )),
              const Spacer(),
            ]),
          )),
    ],),);
  }
}

