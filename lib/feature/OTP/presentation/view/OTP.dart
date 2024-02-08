import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemOTPbar.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custembutten.dart';
import 'package:mute_motion/feature/OTP/presentation/view/widget/custemcodefield.dart';
import 'package:mute_motion/feature/resgisterscreen/model/regmodel.dart';
import 'package:mute_motion/models/OTP_provider.dart';

class OTP extends StatefulWidget {
  OTP({super.key,required this.rg, });
    final regmodel rg;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  //String email = "yaraafifi106@gmail.com";
  TextEditingController code1 = TextEditingController();

  TextEditingController code2 = TextEditingController();

  TextEditingController code3 = TextEditingController();

  TextEditingController code4 = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey();

    bool isLoading = false;

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
                    height: 40,
                  ),
                  custemOTPbar(),
                  SizedBox(
                    height: 56,
                  ),
                  Text(
                    "Please enter the 4-digit code sent via Email on\n ${widget.rg.email}",
                    style: TextStyle(
                        color: Color(0xff003248),
                        fontFamily: 'Comfortaa',
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 19,
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 71,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      custemcodefield(
                        codecontroller: code1,
                      ),
                      custemcodefield(
                        codecontroller: code2,
                      ),
                      custemcodefield(
                        codecontroller: code3,
                      ),
                      custemcodefield(
                        codecontroller: code4,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 79,
                  ),
                  custembutten(
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
                          email: '${widget.rg?.email}',
                          code: code.toString(),
                          code1: code1,
                          code2: code2,
                          code3: code3,
                          code4: code4,
                          );
                          }
                        isLoading = false;
                        setState(() {});
                      //GoRouter.of(context).push('/navbar');
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Haven’t received OTP code? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Comfortaa',
                          )),
                      TextButton(
                          onPressed: () async {
                            print(widget.rg?.email);
                            await OTPprovider().sendcode(email: '${widget.rg?.email}');
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                                color: Color(0xff003248),
                                fontSize: 16,
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
