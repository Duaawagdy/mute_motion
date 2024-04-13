import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';

class driverdetials extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 380,
      child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                backgroundImage: AssetImage('assets/man.png'),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 62, left: 12),
                  child: getUserName()==null?
                    Text(
                    'User Name',
                    style: TextStyle(
                      color: Color(0xFFF8F8F8),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      height: 0.07,
                    ),
                  )
                    :Text(
                    '${getUserName()}',
                    style: TextStyle(
                      color: Color(0xFFF8F8F8),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      height: 0.07,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8,left: 8.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,size: 11,),
                      Text(
                        '  4.9 (123 Reviewers)',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed:() {GoRouter.of(context).push('/profile');},
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    ),);
  }

}