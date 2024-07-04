import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Import ModalProgressHUD
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/delete_account/data/delete_account_api.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

import 'widgets/cansel_button.dart';
import 'widgets/delete_button.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isLoading = false; // State variable for loading indicator

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading, // Use the state variable
      child: Scaffold(
        backgroundColor: borderColor,
        drawer: NavDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: kprimaryColor),
          title: Text(
            'Delete My Account',
            style: TextStyle(
                fontSize: 20.sp, fontFamily: 'Lato', color: kprimaryColor),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity.w,
          padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15),
          decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 30, // Adjust size to your liking
                    ),
                    SizedBox(width: 3),
                    Padding(
                      padding:  EdgeInsets.only(top: 5.0.h),
                      child: Text(
                        "Deleting your account will:",
                        style: TextStyle(
                          color: borderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  "          - Delete your account info and profile photo\n"
                  "          - Remove all your data\n"
                  "          - Delete your messages history\n"
                  "          - Delete your requests history\n",
                  style: TextStyle(fontSize: 16.sp, color: borderColor),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      deleteAccBtn(
                        text: 'Delete My Account',
                        width: double.infinity.w,
                        height: 60.h,
                        color: Colors.white,
                        textColor: Colors.red,
                        onTap: () async {
                          setState(() {
                            _isLoading = true; // Show the loader
                          });
                          try {
                            await AccountApi().deleteDriverAccount(
                              context: context,
                            );
                          } finally {
                            setState(() {
                              _isLoading = false; // Hide the loader
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        width: double.infinity.w,
                        height: 60.h,
                        child: canselBtn(
                          text: 'Cancel',
                          onTap: () {
                            GoRouter.of(context).push('/orders');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
