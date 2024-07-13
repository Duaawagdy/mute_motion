import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
import 'package:mute_motion/models/api_provider.dart';
import 'package:provider/provider.dart';

import '../../carddetials/presentation/view/card_details.dart';

class RegisterScreen extends StatefulWidget {

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController confirm = TextEditingController();
  TextEditingController passCont = TextEditingController();
  bool Show_Pass = true;

  String? name, age, email, phone, details;
  int? credit;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  bool LoadingIndicator= false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,provider, child) {
        return ModalProgressHUD(
          inAsyncCall: LoadingIndicator,
          child: Scaffold(
            backgroundColor: kprimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset('assets/pana.png'),
                              SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: borderColor,
                                  fontFamily: 'comfortaa',
                                ),
                              ),
                            ),
                            Text(
                              'Please Enter your Info',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: borderColor,
                                fontFamily: 'comfortaa',
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            CustomTextField(
                              cont: nameCont,
                              onChanged: (data) {
                                name = data;
                              },
                              lableText: 'First name & Last name',
                              hintText: "full name",

                              icon: Icons.person,
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            CustomTextField(
                              cont: ageCont,
                              onChanged: (data) {
                                age = data;
                              },
                              icon: Icons.calendar_month,
                              lableText: 'Age',
                              hintText: 'Age',

                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              controller: emailCont,
                              validator: (value) {
                                final bool isEmailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);
                                if (value!.isEmpty) {
                                  return "must not be empty";
                                } else if (!isEmailValid) {
                                  return "Invalid email address";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:  InputDecoration(

                                hintStyle: const TextStyle(
                                    color:Color(0xa6002634),fontFamily: 'comfortaa'),
                                hintText: 'Email',
                                labelText:'Email',
                                labelStyle: TextStyle(color:Color(0xe4003248) ),
                                suffixIcon: Icon(
                                  Icons.mail,
                                  color: borderColor,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                      color: Color(0x9932394a)),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(16)),
                                prefixIconColor: borderColor,
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              controller: passCont,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "must not be empty";
                                } else if (value.length < 6) {
                                  return "Password can't be less than 6 letters";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: Show_Pass,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: Color(0xa6002634),fontFamily: 'comfortaa'),
                                hintText: 'Password',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0x9932394a)),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(16)),
                                prefixIconColor: borderColor,
                                suffixIconColor: borderColor,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Show_Pass = !Show_Pass;
                                    });
                                  },
                                  icon: Icon(
                                      Show_Pass ? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            TextFormField(
                              controller: confirm,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "must not be empty";
                                } else if (value.length < 6) {
                                  return "Password can't be less than 6 letters";
                                } else if (passCont.text != confirm.text) {
                                  return 'Passwords aren\'t identical';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: Show_Pass,
                              decoration: InputDecoration(

                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(
                                    color: Color(0xa6002634),fontFamily: 'comfortaa'),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0x9932394a)),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(16)),
                                suffixIconColor: borderColor,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Show_Pass = !Show_Pass;
                                    });
                                  },
                                  icon: Icon(
                                      Show_Pass ? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            custemTextField(textEditingController: phoneCont, hintText: 'Phone Number',widget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(

                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2),
                                  decoration: const ShapeDecoration(

                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 0,

                                            style:
                                            BorderStyle.solid),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                5.0)),
                                      ),
                                      color: Color(0xff003248)),
                                  child: Text('+20',style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                                  width: 40,
                                  //height: 30,
                                ),
                              ],
                            ),),

                            SizedBox(
                              height: 18.h,
                            ),
                              
                            Container(
                                margin: EdgeInsets.only(),
                                height: 70.h,
                                width: 250.w,
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 1,
                                ).r,

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: borderColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.r),
                                      topRight: Radius.circular(5.r),
                                      bottomRight: Radius.circular(5.r),
                                      bottomLeft: Radius.circular(5.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          buildShowModalBottomSheet(context);
                                        },
                                        child: Text("Credit Details",textAlign: TextAlign.center,)),
                                  // SizedBox(
                                  //   width:205.w,
                                  // ),
                                    IconButton(
                                      onPressed: () {
                                        buildShowModalBottomSheet(context);
                                      },
                                      icon: Icon(Icons.chevron_right),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 18.h,
                            ),
                            Container(
                                margin: EdgeInsets.only(),
                                height: 70.h,
                                width: 250.w,
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 1,
                                ).r,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: borderColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.r),
                                      topRight: Radius.circular(5.r),
                                      bottomRight: Radius.circular(5.r),
                                      bottomLeft: Radius.circular(5.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).push('/cardetails');
                                          print('done');
                                        },
                                        child: Text("Car Details")),
                                  //  SizedBox(
                                  //    width: 232.w,
                                  //  ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                   child: IconButton(
                                     onPressed: () {
                                       GoRouter.of(context).push('/cardetails');
                                       print('done');
                                     },
                                     icon: Icon(Icons.chevron_right),
                                   ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 30.h,
                            ),
                            Container(
                              width: (double.infinity).w,
                              decoration: BoxDecoration(
                                  color: const Color(0xff003248),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: MaterialButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                        setUserEmail(emailCont.text);
                                        LoadingIndicator= true;
                                        setState(() {});
                                      await ApiProvider().userRegistration(
                                          context: context,
                                          fullname: nameCont.text,
                                          age: ageCont.text,
                                          email: emailCont.text,
                                          password: passCont.text,
                                          passwordConfirm: confirm.text,
                                          phone: "0${phoneCont.text}",
                                          carnum: provider.numCont.text,
                                          cvv: provider.cvvController.text,
                                          color: provider.colorCont.text,
                                          cardnum:provider.cardNumberController.text,
                                          cardescription: provider.describeCont.text,
                                          cartype:provider.typeCont.text,
                                          model: provider.modelCont.text,
                                          exdate:provider.expiryDateController.text,
                                      );
                                    }
                                    LoadingIndicator= false;
                                        setState(() {});
                                  },
                                  child:  Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontFamily: 'Comfortaa',
                                        color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('already have an account?',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Comfortaa',
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '  Login',
                                    style: TextStyle(
                                      color: borderColor,
                                      fontSize: 16.sp,
                                      fontFamily: 'Comfortaa',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //Spacer(flex: 1,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.r)),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Card_Details_Screen(),
          );
        });
  }
}

class custemTextField extends StatelessWidget {
  const custemTextField({
    super.key, required this.textEditingController, required this.hintText, required this.widget,
  });
final TextEditingController textEditingController;
final String hintText;
final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: textEditingController,


        cursorColor: const Color(0x9932394a),
        keyboardType: TextInputType.phone,
        maxLength: 10,
        maxLengthEnforcement:
        MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
            prefixIcon: widget,
           // suffixIconColor: const Color(0x9932394a),


            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0x9932394a)),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(16)),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0xa6002634),fontFamily: 'comfortaa'),
            contentPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8)),
      ),
    );
  }
}
