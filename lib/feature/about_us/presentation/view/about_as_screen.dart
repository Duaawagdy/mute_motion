import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class About_As extends StatelessWidget {
  const About_As({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
          style:
              TextStyle(fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        //leading: Icon(Icons.menu,color: Colors.white,),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: (double.infinity).w,
        padding:  EdgeInsets.only(
          top: 20.h,
          left: 15.w,
        ).r,
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Let’s introduce ourselves!',
                style: TextStyle(
                    fontSize: 22.sp, fontFamily: 'Lato', color: Color(0xff003248)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Image.asset('assets/about_us.png'),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(right: 22.w, left: 10.w),
                padding: EdgeInsets.all(8).w,
                height: 465.h,
                width: (double.infinity).w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Color(0xff003248)),
                ),
                child: SingleChildScrollView(
                  child: Text(
                      "The MuteMotion project aims to create an innovative smart taxi service catering specifically to deaf and mute drivers. It involves the development of advanced driver assistance systems (ADAS) using artificial intelligence (AI) and mobile application technologies. By enhancing safety features, communication tools, and convenience, MuteMotion seeks to empower the deaf/mute community with job opportunities and effective interaction platforms.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Comfortaa',
                          color: Color(0xff003248))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
