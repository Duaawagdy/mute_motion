import 'dart:typed_data';
import 'dart:convert'; // For base64 decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class driverDetails extends StatefulWidget {
  @override
  State<driverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<driverDetails> {
  String userName = '';
  String userRating = '';
  String reviews = '';
  String profileImg = '';
  Uint8List? _profileImage;
  bool _isLoadingImage = true;

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
      profileImg = prefs.getString('profileImg') ?? '';
    });
  }

  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profileImg');
    if (base64Image != null) {
      try {
        setState(() {
          _profileImage = base64Decode(base64Image);
          _isLoadingImage = false;
        });
      } catch (e) {
        print('Error decoding image: $e');
        setState(() {
          _isLoadingImage = false;
        });
      }
    } else {
      setState(() {
        _isLoadingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: 315.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isLoadingImage
              ? CircularProgressIndicator()
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38.r,
                  backgroundImage: _profileImage != null
                      ? MemoryImage(_profileImage!)
                      :  (profileImg.isNotEmpty
                                    ? NetworkImage(profileImg)
                                    : NetworkImage('https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2281862025.jpg')) // Placeholder image
                                        as ImageProvider<Object>?,
                ),
          //SizedBox(width: 5.w),
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
                    Icon(FontAwesomeIcons.solidStar, color: Colors.yellow, size: 10),
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
          //SizedBox(width: 5.w),
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
