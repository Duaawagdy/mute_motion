import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/about_us/view/about_as_screen.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/driverdetials.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/menu.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/menubody.dart';
//import 'package:passenger_app/constants.dart';

class NavDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
final Color darkGreen=Color(0xff003248);
    return Drawer(

      backgroundColor: darkGreen,

      child: ListView(
          padding: EdgeInsets.zero,
        children:[
          Container(
            height: 170,
              width: 395,
              decoration: BoxDecoration(color: darkGreen),
              child: driverdetials()),

         menubody()
  ]),
    );
  }
}
