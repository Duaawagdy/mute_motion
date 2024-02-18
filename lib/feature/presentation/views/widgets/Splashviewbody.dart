
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/Assets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashviewbody extends StatefulWidget{
  @override
  State<Splashviewbody> createState() => _SplashviewbodyState();
}

class _SplashviewbodyState extends State<Splashviewbody> with SingleTickerProviderStateMixin{
  late AnimationController _animationcontroller;
  @override
  void initState(){
    super.initState();
    _animationcontroller=AnimationController(vsync: this,
        duration:Duration(seconds: 3) );
    _animationcontroller.forward();

    tohome();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff003248),
      body: Center(
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.5,end: 1).animate(
              CurvedAnimation(parent: _animationcontroller,
                  curve: Curves.easeOut)),
          child: Container(
            height: 510,
            width: 510,
            child: Image.asset(AssetsData.logo),
          ),
        ),
      ),
    );
  }
  void tohome() {
    Future.delayed(Duration(seconds: 5),() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      print(email);
      email == null ? GoRouter.of(context).push( '/loginview'): GoRouter.of(context).push('/navbar');

    });
  }
}