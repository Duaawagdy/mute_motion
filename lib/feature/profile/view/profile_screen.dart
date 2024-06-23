import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 80),
                //height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      userName.isNotEmpty ? userName : 'User Name',
                      style: TextStyle(
                      color: borderColor,
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      height: 0.07,
                    ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,size: 12,),
                      SizedBox(width: 5,),
                      Text(
                      userRating.isNotEmpty ? userRating : '',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: borderColor,
                          fontSize: 12,
                        ),
                    ),
                      SizedBox(width: 10,),
                      Text(
                      reviews.isNotEmpty ? '${reviews} Reviews' : '',
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          color: borderColor,
                          fontSize: 12,
                        ),
                    ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 30, left: 5, right: 22, bottom: 5),
                        height: 110,
                        width: 355,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        decoration: const BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Car Type:  ${_userData.cartype} ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Color:  ${_userData.color}      Model:  ${_userData.model}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '(automatic-comfort-4 seats)',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                  ]),
                              //SizedBox(width: 10,),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, right: 25),
                                child: Image.asset('assets/car 1.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // margin:
                      //     EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
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
                                height: 6,
                              ),
                              Profile_item(
                                  textTitle: 'Email', text: _userData.email),
                              SizedBox(
                                height: 6,
                              ),
                              Profile_item(
                                  textTitle: 'Phone', text: _userData.phone),
                              SizedBox(
                                height: 6,
                              ),
                              Profile_item(
                                  textTitle: 'Age', text: _userData.age),
                              SizedBox(
                                height: 15,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: _selectedImageBytes != null
                    ? MemoryImage(_selectedImageBytes!)
                    : AssetImage('assets/man.png') as ImageProvider<Object>?,
                )),
            Positioned(
              top: 123,
              right: 130,
              child: Container(
                width: 30,
                height: 30,
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
                                20.0), // Adjust the radius as needed
                            topRight: Radius.circular(
                                20.0), // Adjust the radius as needed
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
                    size: 27,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
