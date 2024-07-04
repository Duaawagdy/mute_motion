import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class feedbackBtn extends StatelessWidget {
  feedbackBtn({super.key, this.onTap, required this.text,this.height,this.width,this.color,this.textColor});
  VoidCallback? onTap;
  String text;
  double? height;
  double? width;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        width: width,
        height: height,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20.sp,
            color: textColor,
          ),
        )),
      ),
    );
  }
}
