import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 250.h,),
          Text('You are offline',
                  style: TextStyle(fontSize: 30.sp,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
          Text('Be online to get your orders now',
                  style: TextStyle(fontSize: 20.sp,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
        ],
      )
    ;
  }
}