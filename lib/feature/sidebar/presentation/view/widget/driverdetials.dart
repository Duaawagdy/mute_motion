import 'dart:typed_data';
import 'dart:convert'; // For base64 decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class driverdetials extends StatefulWidget {
  @override
  State<driverdetials> createState() => _driverdetialsState();
}

class _driverdetialsState extends State<driverdetials> {
  String userName = '';
  String userRating = '';
  String reviews = '';
  Uint8List? _profileImage;

  @override
  void initState() {
    super.initState();
    _getUserNameRateReview();
    _loadProfileImage(); // Load the profile image
  }

  Future<void> _getUserNameRateReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('fullname') ?? '';
      userRating = prefs.getString('rating') ?? '';
      reviews = prefs.getString('numberOfReviews') ?? '';
    });
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profile_image');
    if (base64Image != null) {
      setState(() {
        _profileImage = base64Decode(base64Image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 309.w,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 38.r,
            backgroundImage: _profileImage != null
                ? MemoryImage(_profileImage!)
                : AssetImage('assets/man.png') as ImageProvider<Object>?,
          ),
          SizedBox(width: 5.w),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 32.h, left: 12.w),
                child: Text(
                  userName.isNotEmpty ? userName : 'User Name',
                  style: TextStyle(
                    color: Color(0xFFF8F8F8),
                    fontSize: 16.sp,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w700,
                    height: 0.07.h,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h, left: 8.0.w),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.solidStar, color: Colors.yellow, size: 11),
                    SizedBox(width: 5.w),
                    Text(
                      userRating.isNotEmpty ? userRating : '',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      reviews.isNotEmpty ? '$reviews Reviews' : '',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/profile');
            },
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
