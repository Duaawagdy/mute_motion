import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:mute_motion/feature/traslator/view/cameratranlator.dart';
class Translator_Screen extends StatelessWidget {
  const Translator_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text(
          'Translator',
          style:
              TextStyle(fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: (double.infinity).w,
          padding:  EdgeInsets.only(
            top: 20.h,
            left: 15.w,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
          child: Padding(
            padding:  EdgeInsets.only(right:20.w, top: 40.h, bottom:20.h, left: 10.w),
            child: Column(
              children: [
                Image.asset('assets/translator.png'),
                Text(
                  'Sign To Text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff003248)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Please start translator and open your camera to translate your sign language to text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Comfortaa',
                      color: Color(0xff003248)),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Container(
                  width: (double.infinity).w,
                  decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: MaterialButton(
                      onPressed: (){
                        Navigator.of(context).push( MaterialPageRoute (
                          builder: (BuildContext context) =>  cameratranslator(),
                        ),);
                      },
                      child: Text(
                        "Start Translator",
                        style: TextStyle(fontSize: 22.sp,fontFamily: 'Comfortaa', color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
