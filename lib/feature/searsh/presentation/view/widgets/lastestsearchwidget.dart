import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/core/utils/constant.dart';

class LastestSearch extends StatelessWidget {
  LastestSearch({super.key, this.cityname, this.distance});
  String? cityname;
  String? distance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:Axis.horizontal,
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.locationDot,
            color: borderColor,
            size: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            cityname!,
            style: TextStyle(
              color: Color(0xFF003248),
              fontSize: 16,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            width: 110,
          ),
          Text(
            distance!,
            style: TextStyle(
              color: Color(0xBF003248),
              fontSize: 15,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.30,
            ),
          ),
        ],
      ),
    );
  }
}
