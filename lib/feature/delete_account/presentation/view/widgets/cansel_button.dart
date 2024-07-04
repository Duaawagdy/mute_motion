import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/core/utils/constant.dart';


class canselBtn extends StatelessWidget {
  canselBtn({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
                      onPressed: onTap,
                      child: Text(
                        '${text}',
                        style: TextStyle(
                            color: borderColor,
                            fontSize: 18.sp,
                            fontFamily: 'Comfortaa',),
                      ),
                      );
  }
}
