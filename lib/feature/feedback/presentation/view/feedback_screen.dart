
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/core/utils/routing/AppRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/feedback_api.dart';
import 'widgets/Feedback_textField.dart';
import 'widgets/custom_button.dart';
import 'widgets/skip_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: borderColor,
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: TextStyle(
              fontSize: 25.sp, fontFamily: 'Lato', color: kprimaryColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity.w,
        padding: EdgeInsets.only(top: 30.h, left: 15.w, right: 15),
        decoration: BoxDecoration(
            color: kprimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Provide your feedback about your ride with this passenger',
                style: TextStyle(fontSize: 18.sp,color: borderColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.h,
              ),
              ClipOval(
                child: Image.asset(
                  'assets/driver_feedback.png',
                  width: 345.w, // Adjust the width as needed
                  height: 220.h, // Adjust the height as needed
                  fit: BoxFit.cover, // To fill the shape
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Form(
                key: formKey,
                child: FeedbackTextField(
                  controller: feedbackCont,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Feedback must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  skipBtn(
                    text: 'Skip',
                    onTap: () {
                      approuter.clearAndNavigate(context, "/navbar");
                      removevalues();
                      //GoRouter.of(context).push('/navbar');
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  feedbackBtn(
                    text: 'Submit',
                    color: borderColor,
                    width: 140.w,
                    height: 50.h,
                    textColor: Colors.white,
                    onTap: () {
                      {
                        if (formKey.currentState!.validate()) {
                          RatingApi().userFeedBack(
                            context: context,
                            commentText: feedbackCont,
                      );
                          removevalues();
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> removevalues()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('orderId');
prefs.remove('passengerId');
      prefs.remove('startpointslat');
      prefs.remove('startpointslon');


    prefs.remove('endtpointslat');
    prefs.remove('endtpointslon');


     prefs.remove('cost');

    prefs.remove('startlocationname');
        prefs.remove('endlocationname' );


  }
}
