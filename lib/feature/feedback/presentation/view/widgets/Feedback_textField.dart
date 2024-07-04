import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/core/utils/constant.dart';
class FeedbackTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const FeedbackTextField({super.key,
  required this.validator,
  required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: 220.h,
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.r,
              blurRadius: 5.r,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding:  EdgeInsets.symmetric(horizontal: 8.w),
        child: TextFormField(
          validator: validator,
          controller: controller,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Add your comments...',
            hintStyle: TextStyle(color: borderColor.withOpacity(.4)),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      );
    
  }
}