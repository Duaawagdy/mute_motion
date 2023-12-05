import 'package:flutter/material.dart';
class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 250),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('You are offline',
                    style: TextStyle(fontSize: 26,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
            Text('Be online to get your orders now',
                    style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
          ],
        ),
    )
    ;
  }
}