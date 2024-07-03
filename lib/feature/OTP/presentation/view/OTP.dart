import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemOTPbar.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custembutten.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemcodefield.dart';

import '../../data/OTP_provider.dart';

class OTP extends StatefulWidget {
  OTP({super.key,});
    //final regmodel rg;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  
  TextEditingController code1 = TextEditingController();

  TextEditingController code2 = TextEditingController();

  TextEditingController code3 = TextEditingController();

  TextEditingController code4 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

    GlobalKey<FormState> formKey = GlobalKey();

    bool isLoading = false;
  void _onFieldChanged(String value, int index) {
    if (value.length == 1) {
      switch (index) {
        case 0:
          FocusScope.of(context).requestFocus(focusNode2);
          break;
        case 1:
          FocusScope.of(context).requestFocus(focusNode3);
          break;
        case 2:
          FocusScope.of(context).requestFocus(focusNode4);
          break;
        case 3:
          focusNode4.unfocus();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(

          child: Form(
            key: formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  custemOTPbar(),
                  SizedBox(
                    height: 56.h,
                  ),
                  Text(
                    //"Please enter the 4-digit code sent via Email on\n ${widget.rg.email}",
                    "Please enter the 4-digit code sent via Email on\n ${getUserEmail()}",
                    style: TextStyle(
                        color: Color(0xff003248),
                        fontFamily: 'Comfortaa',
                        fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 160),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit your Email",
                        style: TextStyle(
                            color: Color(0xff003248),
                            fontFamily: 'Comfortaa',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 71.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      custemcodefield(
                        codecontroller: code1, focusNode: focusNode1,
                        onChanged: (value) => _onFieldChanged(value, 0),
                      ),
                      custemcodefield(
                        codecontroller: code2,  focusNode: focusNode2,
                        onChanged: (value) => _onFieldChanged(value, 1),
                      ),
                      custemcodefield(
                        codecontroller: code3,  focusNode: focusNode3,
                        onChanged: (value) => _onFieldChanged(value, 2),
                      ),
                      custemcodefield(
                        codecontroller: code4, focusNode: focusNode4,
                        onChanged: (value) => _onFieldChanged(value, 3),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 79.h,
                  ),
                  custembutten(
                    text: 'Confirm',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        var list = [
                        code1.text,
                        code2.text,
                        code3.text,
                        code4.text
                      ];
                      var code = StringBuffer();
          
                      list.forEach((item) {
                        code.write(item);
                      });
          
                      print(code);
    
                      await OTPprovider().code(
                          context: context,
                          //email: '${widget.rg?.email}',
                          email: '${getUserEmail()}',
                          code: code.toString(),
                          code1: code1,
                          code2: code2,
                          code3: code3,
                          code4: code4,
                          );
                          }
                        isLoading = false;
                        setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Haven’t received OTP code? ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Comfortaa',
                          )),
                      TextButton(
                          onPressed: () async {
                            print(getUserEmail());
                            //await OTPprovider().sendcode(email: '${widget.rg?.email}');
                            await OTPprovider().sendcode(email: '${getUserEmail()}');
                          },
                          child:  Text(
                            "Resend OTP",
                            style: TextStyle(
                                color: Color(0xff003248),
                                fontSize: 18.sp,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
