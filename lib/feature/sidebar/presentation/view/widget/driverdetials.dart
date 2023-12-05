import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class driverdetials extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 35,
              backgroundImage: AssetImage('assets/man.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hassan Mohamed',
                  style: TextStyle(
                    color: Color(0xFFF8F8F8),
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: IconButton(
              onPressed:() {GoRouter.of(context).push('/profile');},
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    ),);
  }

}