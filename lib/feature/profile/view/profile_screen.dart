import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/profile/profile_mode.dart';
import 'package:mute_motion/feature/profile/view/buttom_sheet.dart';
import 'package:mute_motion/feature/profile/view/profile_item.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:mute_motion/models/getUserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  String userName = '';
  String userRating = '';
  String reviews = '';
  Future<void> _getUserNameRateReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('fullname') ?? '';
      userRating = prefs.getString('rating') ?? '';
      reviews = prefs.getString('numberOfReviews') ?? '';
    });
  }
  late ProfileModel _userData = ProfileModel(
    cartype: '',
    color: '',
    model: '',
    fullname: '',
    email: '',
    phone: '',
    age: '',
  );
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
    Uint8List? _selectedImageBytes;
  @override
  void initState() {
    super.initState();
    getInfo();
    _getUserNameRateReview();
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

  void _takePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    // Open the camera and capture a photo
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  void _openGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    // Open the gallery and select an image
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.only(bottom: 8.0.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 80.h),
                  //height: MediaQuery.of(context).size.height,
                  width: (double.infinity).w,
                  padding:  EdgeInsets.only(
                    top: 20.h,
                    left: 15.w,
                    bottom: 20.h,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 85.h,
                      ),
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
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,size: 12.sp,),
                        SizedBox(width: 5.w,),
                        Text(
                        userRating.isNotEmpty ? userRating : '',
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            color: borderColor,
                            fontSize: 14.sp,
                          ),
                      ),
                        SizedBox(width: 10.w,),
                        Text(
                        reviews.isNotEmpty ? '${reviews} Reviews' : '',
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            color: borderColor,
                            fontSize: 14.sp,
                          ),
                      ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 30.h, left: 5.w, right: 18.w, bottom: 25.h),
                        child: Container(
                          height: 110.h,
                          width: 395.w,
                          decoration: BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r))),
                          child: Container(
                            padding: EdgeInsets.only(top: 11.h,left: 18.w,bottom: 7.h,right: 19.w),
                            child: Row(
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Car Type:  ${_userData.cartype} ',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Lato',
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        'Color:  ${_userData.color}      Model:  ${_userData.model}',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Lato',
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        '(automatic-comfort-4 seats)',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Lato',
                                            color: Colors.white),
                                      ),
                                    ]),
                                    SizedBox(width: 10.w,),
                                Image.asset('assets/car 1.png',width: 100.w,height: 95.h,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: (double.infinity).w,
                        padding:  EdgeInsets.only(
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
                                Profile_item(
                                    textTitle: 'Name', text: _userData.fullname),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Profile_item(
                                    textTitle: 'Email', text: _userData.email),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Profile_item(
                                    textTitle: 'Phone', text: _userData.phone),
                                SizedBox(
                                  height:14.h,
                                ),
                                Profile_item(
                                    textTitle: 'Age', text: _userData.age),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0.h,
                  child: CircleAvatar(
                    radius: 80.r,
                    backgroundColor: Colors.white,
                    backgroundImage: _selectedImageBytes != null
                      ? MemoryImage(_selectedImageBytes!)
                      : AssetImage('assets/man.png') as ImageProvider<Object>?,
                  )),
              Positioned(
                top: 123.h,
                right: 150.w,
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Color(0xff003248),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  20.0.r), // Adjust the radius as needed
                              topRight: Radius.circular(
                                  20.0.r), // Adjust the radius as needed
                            ),
                          ),
                          isScrollControlled: true,
                          builder: ((builder) => ButtomSheet(
                                takePhoto: _takePhoto,
                                openGallery: _openGallery,
                              )));
                    },
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 27.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
