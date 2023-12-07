import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';

class Profile_item extends StatelessWidget {
  const Profile_item({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 8),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return "please enter your data";
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(
            text,
            style: TextStyle(
              color: Colors.black.withOpacity(0.699999988079071),
              fontSize: 16,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.40,
            ),
          ),
          hintStyle: TextStyle(
            color: borderColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        ),
      ),
    );
  }
}
