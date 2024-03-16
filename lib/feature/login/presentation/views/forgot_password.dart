import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custembutten.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemcodefield.dart';
import 'package:mute_motion/models/forgot_password_api.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPassword extends StatefulWidget {
  // ForgotPassword({super.key, required this.rg,});
  // final regmodel rg;
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController code1 = TextEditingController();

  TextEditingController code2 = TextEditingController();

  TextEditingController code3 = TextEditingController();

  TextEditingController code4 = TextEditingController();

  TextEditingController emailCont = TextEditingController();

  TextEditingController passCont = TextEditingController();

  TextEditingController confirm = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  final CountdownController _controller =
      new CountdownController(autoStart: true);

  bool isLoading = false;
  bool Show_Pass = true;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Text(
                      'Reset Your Password',
                      style: TextStyle(fontSize: 25, color: borderColor),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: borderColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Please enter the 4-digit code sent via Email on   ${getUserEmail()}",
                      style: TextStyle(
                          color: Color(0xff003248),
                          fontFamily: 'Comfortaa',
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          custemcodefield(
                            codecontroller: code1,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          custemcodefield(
                            codecontroller: code2,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          custemcodefield(
                            codecontroller: code3,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          custemcodefield(
                            codecontroller: code4,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                      height: 18,
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
                        label: Text(
                          "New password",
                          style: TextStyle(color: borderColor),
                        ),
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
                      height: 18,
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
                        label: Text(
                          "Confirm password",
                          style: TextStyle(color: borderColor),
                        ),
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
                      height: 40,
                    ),
                    custembutten(
                      text: 'Reset Your Password',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          await FogotPsswordApi().ChangePassword(
                            context: context,
                            emailCont: emailCont,
                            passCont: passCont,
                            ConfPasscont: confirm,
                            code1: code1,
                            code2: code2,
                            code3: code3,
                            code4: code4,
                          );
                          isLoading = false;
                          setState(() {});
                        }
                        ;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("The code will expire automatically in ",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Comfortaa',
                              )),
                          Countdown(
                            controller: _controller,
                            seconds: 300,
                            build: (BuildContext context, double time) =>
                                Text(time.toString()),
                            interval: Duration(milliseconds: 100),
                            onFinished: () {
                              setState(() {});
                              isVisible = true;
                              print('Timer is done!');
                            },
                          )
                        ],
                      ),
                    ),
                    Visibility(
                  visible: isVisible,
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await FogotPsswordApi()
                            .ResentCode(context: context, emailCont: emailCont);
                            isLoading = false;
                        setState(() {});
                        _controller.restart();
                      },
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                            color: borderColor,
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
