import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:video_player/video_player.dart';

class CarSystemScreen extends StatefulWidget {
  @override
  _CarSystemScreenState createState() => _CarSystemScreenState();
}

class _CarSystemScreenState extends State<CarSystemScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false; // State to track if the video is playing

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/Steering_wheel_demo.mp4', // Path to your video file
    )
      ..initialize().then((_) {
        setState(() {}); // When the video is initialized, update the UI
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003248),
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Car System',
          style: TextStyle(
            fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity.w,
        padding: EdgeInsets.only(top: 30.h, left: 15.w, right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          )),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'This is an instruction video to teach you how to use your car.',
                style: TextStyle(fontSize: 20.sp,color: Color(0xff003248)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70),
              if (_controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              else
                Center(child: CircularProgressIndicator()), // Show a loader until the video is loaded
              SizedBox(height: 40.h),
              _buildControlButtons(),
              SizedBox(height: 40.h),
              _buildRestartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.replay_10,
            size: 40, // Adjust size as needed
            color: Color(0xff003248), // Set to the same color
          ),
          onPressed: () {
            _skipBackward();
          },
        ),
        IconButton(
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            size: 40, // Adjust size as needed
            color: Color(0xff003248), // Set to the same color
          ),
          onPressed: () {
            setState(() {
              if (_isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
              _isPlaying = !_isPlaying;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.forward_10,
            size: 40, // Adjust size as needed
            color: Color(0xff003248), // Set to the same color
          ),
          onPressed: () {
            _skipForward();
          },
        ),
      ],
    );
  }

  Widget _buildRestartButton() {
    return ElevatedButton(
      onPressed: () {
        _controller.seekTo(Duration.zero);
        _controller.play();
        setState(() {
          _isPlaying = true;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Color(0xff003248), // Text color
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'Lato',
        ),
      ),
      child: Text('Restart Video'),
    );
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    if (newPosition < _controller.value.duration) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(_controller.value.duration);
    }
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(Duration.zero);
    }
  }
}
