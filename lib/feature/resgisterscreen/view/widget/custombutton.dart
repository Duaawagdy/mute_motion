import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';

class CustomButon extends StatelessWidget {
  CustomButon({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20,
            color: kprimaryColor,
          ),
        )),
      ),
    );
  }
}
