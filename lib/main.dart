import 'package:flutter/material.dart';
import 'package:mute_motion/feature/login/presentation/views/loginview.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_screen(),
    );
    // .router(
    //   debugShowCheckedModeBanner: false,
    //     routerConfig: approuter.router,
    //     //theme: ThemeData.dark(useMaterial3: false).copyWith(scaffoldBackgroundColor: Color(0xff003248))
    // );
  }
}