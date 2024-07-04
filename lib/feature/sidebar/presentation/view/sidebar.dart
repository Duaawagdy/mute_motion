import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/driverdetials.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/menubody.dart';
//import 'package:passenger_app/constants.dart';

class NavDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;
    final Color darkGreen = Color(0xff003248);
    return Drawer(
      backgroundColor: darkGreen,
      child: ListView(padding: EdgeInsets.zero, children: [
        Padding(
          padding:  EdgeInsets.only(top: 20.h,left: 10.w,bottom: 12.h,),
          child: driverDetails(),
        ),
        menubody(),
      ]),
    );
  }
}
