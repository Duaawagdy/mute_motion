import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/carddetials/view/card_details.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
import 'package:mute_motion/models/api_provider.dart';
import 'package:provider/provider.dart';

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
              padding: const EdgeInsets.all(20.0),
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
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Welcome',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: borderColor,
                                  fontFamily: 'comfortaa',
                                ),
                              ),
                            ),
                            Text(
                              'Please Enter your Info',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: borderColor,
                                fontFamily: 'comfortaa',
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              cont: nameCont,
                              onChanged: (data) {
                                name = data;
                              },
                              hintText: 'Full Name',
                              icon: Icons.person,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              cont: ageCont,
                              onChanged: (data) {
                                age = data;
                              },
                              icon: Icons.calendar_month,
                              hintText: 'Age',
                            ),
                            SizedBox(
                              height: 18,
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
                              decoration: const InputDecoration(
                                label: Text(
                                  "Email",
                                  style: TextStyle(color: borderColor),
                                ),
                                hintText: 'Email',
                                suffixIcon: Icon(
                                  Icons.mail,
                                  color: borderColor,
                                ),
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
                                  "Password",
                                  style: TextStyle(color: borderColor),
                                ),
                                hintText: 'Password',
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
                                  icon: Icon(
                                      Show_Pass ? Icons.visibility_off : Icons.visibility),
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
                                  "Confirm Password",
                                  style: TextStyle(color: borderColor),
                                ),
                                hintText: 'Confirm Password',
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
                                  icon: Icon(
                                      Show_Pass ? Icons.visibility_off : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              cont: phoneCont,
                              onChanged: (data) {
                                phone = data;
                              },
                              hintText: 'Phone',
                              icon: Icons.call,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                              
                            Container(
                                margin: EdgeInsets.only(),
                                height: 58,
                                width: 250,
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: borderColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          buildShowModalBottomSheet(context);
                                        },
                                        child: Text("Credit Details")),
                                    SizedBox(
                                      width: 200,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        buildShowModalBottomSheet(context);
                                      },
                                      icon: Icon(Icons.chevron_right),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                                margin: EdgeInsets.only(),
                                height: 58,
                                width: 250,
                                padding: const EdgeInsets.only(
                                  top: 2,
                                  left: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: borderColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context).push('/cardetails');
                                          print('done');
                                        },
                                        child: Text("Car Details")),
                                    SizedBox(
                                      width: 215,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        GoRouter.of(context).push('/cardetails');
                                        print('done');
                                      },
                                      icon: Icon(Icons.chevron_right),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xff003248),
                                  borderRadius: BorderRadius.circular(20)),
                              child: MaterialButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                        setUserEmail(emailCont.text);
                                        LoadingIndicator= true;
                                        setState(() {});
                                      await ApiProvide().UserRegisteration(
                                          context: context,
                                          fullname: nameCont.text,
                                          age: ageCont.text,
                                          email: emailCont.text,
                                          password: passCont.text,
                                          passwordConfirm: confirm.text,
                                          phone: phoneCont.text,
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
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'Comfortaa',
                                        color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('already have an account?',
                                    style: TextStyle(
                                      fontSize: 15,
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
                                      fontSize: 16,
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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
