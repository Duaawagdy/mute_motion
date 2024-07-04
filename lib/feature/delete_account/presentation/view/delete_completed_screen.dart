
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';

import 'widgets/delete_button.dart'; // Add url_launcher package



class DeleteCompletedScreen extends StatelessWidget {
  final String email = "mutemotion2024@gmail.com"; // Your email address

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF9F6), // Set background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0).w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Icon(
                Icons.check_circle_outline,
                color: Color(0xFF5CB85C), // Darker green for checkmark
                size: 100,
              ),
              SizedBox(height: 20),
              // Message text
              Text(
                'Your account has been deleted',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: borderColor, // Darker text color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Subtext
              Text(
                'Thank you for using Mute_Motion App!',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: borderColor.withOpacity(.4), // Lighter text color
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              // Email contact information
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: borderColor.withOpacity(.4), // Default text color
                  ),
                  children: [
                    TextSpan(
                      text: 'For more info, contact us at ',
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              // Finish button
              deleteAccBtn(
                text: 'Finish',
                color: Colors.red,
                textColor: kprimaryColor,
                height: 55.h,
                width: double.infinity,
                onTap: () {
                  // Handle finish button tap
                  GoRouter.of(context).push('/loginview'); // Example action: go back
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}