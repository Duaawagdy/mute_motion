import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/models/api_provider.dart';
import 'package:mute_motion/models/forgot_password_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_screen extends StatefulWidget {
  login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  // ignore: non_constant_identifier_names
  bool Show_Pass = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0).w,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/pana.png'),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child:  Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontFamily: 'Comfortaa',
                          color: borderColor),
                    ),
                  ),
                   Center(
                      child: Text("Please Enter your info",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Comfortaa',
                              color: borderColor))),
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
                        return "Email must not be empty";
                      } else if (!isEmailValid) {
                        return "Invalid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(color: borderColor),
                      ),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
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
                        return "Password must not be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: Show_Pass,
                    decoration: InputDecoration(
                      label: Text(
                        "Password",
                        style: TextStyle(color: borderColor),
                      ),
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
                      prefixIconColor: borderColor,
                      suffixIconColor: borderColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            Show_Pass = !Show_Pass;
                          });
                        },
                        icon: Icon(Show_Pass
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff003248),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', emailCont.text);
                            await ApiProvider().userLogin(
                                context: context,
                                emailCont: emailCont,
                                passCont: passCont);
                            isLoading = false;
                            setState(() {});
                          }
                        },
                        child:  Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: 'Comfortaa',
                              color: Colors.white),
                        )),
                  ),
                  TextButton(
                      onPressed: () async{
                        setUserEmail(emailCont.text);
                        setState(() {
                        isLoading = true;
                      });
                        await FogotPsswordApi().ResetPassword(context: context, emailCont: emailCont);
                        setState(() {
                        isLoading = false;
                      });
                      },
                      child:  Text(
                        "forgot your password",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.sp,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold),
                      ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Comfortaa',
                          )),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).push('/resgister');
                          },
                          child:  Text(
                            "Register now",
                            style: TextStyle(
                                color: borderColor,
                                fontSize: 18.sp,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
