import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';

class Profile_item extends StatelessWidget {
  const Profile_item({
    super.key,
    required this.textTitle,
    required this.text,
  });
  final String textTitle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(
              color: borderColor,
              fontSize: 16,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.40,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: TextStyle(
              color: borderColor.withOpacity(0.699999988079071),
              fontSize: 16,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.40,
            ),
          ),
          Divider(
            color: borderColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
