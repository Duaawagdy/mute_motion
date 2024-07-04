import 'dart:convert'; // For base64 encoding/decoding
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constant.dart';
import '../../data/models/profile_mode.dart';
import '../../data/repos/getUserInfo.dart';
import 'widgets/buttom_sheet.dart';
import 'widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<ProfileScreen> {
  String userName = '';
  String userRating = '';
  String reviews = '';
  String profileImg = '';
  Uint8List? _selectedImageBytes;
  bool isLoading = false;
  bool isImageLoading = true; // Add this state variable
  String? _base64Image;

  final ImagePicker _picker = ImagePicker();
  late ProfileModel _userData = ProfileModel(
    cartype: '',
    color: '',
    model: '',
    fullname: '',
    email: '',
    phone: '',
    age: '',
  );

  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getInfo();
    _getUserNameRateReview();
    _loadImage(); // Load the image from SharedPreferences
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

  Future<void> getInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      ProfileModel userData = await UserInfo.getUserInfo(token!);

      setState(() {
        _userData = userData;
      });
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveImage(Uint8List imageBytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token != null) {
      String base64Image = base64Encode(imageBytes);
      await prefs.setString('profile_image_$token', base64Image);
      await prefs.setString('profileImg', base64Image); // Save for other screen
    }
  }

  Future<void> _loadImage() async {
    setState(() {
      isImageLoading = true; // Start loading indicator for image
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profileImg');

    if (base64Image != null && base64Image.isNotEmpty) {
      try {
        final decodedBytes = base64Decode(base64Image);
        setState(() {
          _selectedImageBytes = decodedBytes;
        });
      } catch (e) {
        print('Error decoding base64 image: $e');
        setState(() {
          _selectedImageBytes = null;
        });
      }
    } else {
      print('No valid base64 image found in SharedPreferences.');
      setState(() {
        _selectedImageBytes = null;
      });
    }

    setState(() {
      isImageLoading = false; // Stop loading indicator for image
    });
  }

  void _takePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
        _base64Image = base64Encode(bytes);
      });
      await _saveImage(bytes); // Save the image to SharedPreferences
      await _uploadImage(); // Upload the image to the server
    }
  }

  void _openGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
        _base64Image = base64Encode(bytes);
      });
      await _saveImage(bytes); // Save the image to SharedPreferences
      await _uploadImage(); // Upload the image to the server
    }
  }

  Future<void> _uploadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (_base64Image != null && token != null) {
      await UserInfo.uploadImage(token, _base64Image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: const Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          if (isLoading) ...[
            Center(
              child:
                  CircularProgressIndicator(), // Show loader while data is loading
            ),
          ] else ...[
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0.h),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 80.h),
                        width: double.infinity.w,
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 15.w,
                          bottom: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 85.h),
                            Text(
                              userName.isNotEmpty ? userName : 'User Name',
                              style: TextStyle(
                                color: borderColor,
                                fontSize: 18.sp,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                height: 0.07.h,
                              ),
                            ),
                            SizedBox(height: 13.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.yellow,
                                  size: 12.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  userRating.isNotEmpty ? userRating : '',
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: borderColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  reviews.isNotEmpty ? '$reviews Reviews' : '',
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    color: borderColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 30.h,
                                right: 10.w,
                                bottom: 25.h,
                              ),
                              child: Container(
                                height: 120.h,
                                width: 400.w,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.r),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 11.h,
                                    left: 18.w,
                                    bottom: 7.h,
                                    right: 19.w,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Car Type:  ${_userData.cartype} ',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 6.h),
                                            Text(
                                              'Color:  ${_userData.color}      Model:  ${_userData.model}',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 6.h),
                                            Text(
                                              '(automatic-comfort-4 seats)',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15.w),
                                        Image.asset(
                                          'assets/car 1.png',
                                          // width: 90.w,
                                          // height: 95.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: double.infinity.w,
                              padding: EdgeInsets.only(
                                top: 10.h,
                                left: 15.w,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileItem(
                                        textTitle: 'Email',
                                        text: _userData.email),
                                    SizedBox(height: 14.h),
                                    ProfileItem(
                                        textTitle: 'Phone',
                                        text: _userData.phone),
                                    SizedBox(height: 14.h),
                                    ProfileItem(
                                        textTitle: 'Age', text: _userData.age),
                                    SizedBox(height: 15.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80.r,
                            backgroundColor: Colors.white,
                            backgroundImage: _selectedImageBytes != null
                                ? MemoryImage(_selectedImageBytes!)
                                : (profileImg.isNotEmpty
                                        ? NetworkImage(profileImg)
                                        : NetworkImage(
                                            'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2281862025.jpg')) // Placeholder image
                                    as ImageProvider<Object>?,
                            onBackgroundImageError: (_, __) {
                              setState(() {
                                isImageLoading = false; // Hide loader on error
                              });
                            },
                          ),
                          if (isImageLoading)
                            CircularProgressIndicator(), // Show loader while image is loading
                        ],
                      ),
                    ),
                    Positioned(
                      top: 123.h,
                      right: 150.w,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: const Color(0xff003248),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0.r),
                                  topRight: Radius.circular(20.0.r),
                                ),
                              ),
                              isScrollControlled: true,
                              builder: (builder) => ButtomSheet(
                                takePhoto: _takePhoto,
                                openGallery: _openGallery,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 27.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
