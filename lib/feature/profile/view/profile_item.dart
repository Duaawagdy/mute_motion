import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/core/utils/constant.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.textTitle,
    required this.text,
  });
  final String textTitle;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 30.w, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textTitle,
            style: TextStyle(
              color: borderColor,
              fontSize: 16.sp,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.40.w,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            text,
            style: TextStyle(
              color: borderColor.withOpacity(0.699999988079071),
              fontSize: 16.sp,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.40.w,
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
