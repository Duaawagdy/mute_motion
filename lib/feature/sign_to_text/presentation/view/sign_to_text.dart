import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Sign_To_Text extends StatelessWidget {
  const Sign_To_Text({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text('Sign To Text',style: TextStyle(fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 20.h,
            left: 15.w,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  )
                  ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                        EdgeInsets.only(right: 22.w,left: 10.w),
                        padding: EdgeInsets.all(8).w,
                  height: 250.h,
                  width: (double.infinity).w,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Color(0xff003248)),
                  ),
                  child: Icon(Icons.image,size: 68, color: Colors.grey,
                  ),
                ),
                SizedBox(
                      height: 10.h,
                    ),
                Padding(
                  padding:  EdgeInsets.only(right: 23.w, left: 13.w),
                  child: Center(child: Image.asset('assets/sign_to_text.png')),
                ),
                SizedBox(
                      height: 10.h,
                    ),
                Container(
                  margin:
                        EdgeInsets.only(right: 22.w,left: 10.w),
                        padding: EdgeInsets.all(8).w,
                  height: 200.h,
                  width: (double.infinity).w,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Color(0xff003248)),
                  ),
                  child: Text('',
                  style: TextStyle(fontSize: 15.sp,fontFamily: 'Comfortaa', color: Color(0xff003248))),
                ),
                SizedBox(
                      height: 50.h,
                    ),
                Container(
                  margin:
                        EdgeInsets.only(right: 22.w,left: 10.w),
                        //padding: EdgeInsets.all(8),
                width: (double.infinity).w,
                decoration: BoxDecoration(
                    color: const Color(0xff003248),
                    borderRadius: BorderRadius.circular(15.r)),
                child: MaterialButton(
                    onPressed: (){},
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 22.sp,fontFamily: 'Comfortaa', color: Colors.white),
                    )),
              ),
              ],
            ),
          ),
      ),
    );
  }
}