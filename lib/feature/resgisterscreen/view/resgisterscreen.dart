import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/OTP/presentation/view/OTP.dart';
import 'package:mute_motion/feature/carddetials/view/card_details.dart';
import 'package:mute_motion/feature/resgisterscreen/model/regesterationcontant.dart';
import 'package:mute_motion/feature/resgisterscreen/model/regmodel.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
import 'package:mute_motion/models/OTP_provider.dart';
import 'package:mute_motion/models/api_provider.dart';

class RegisterScreen extends StatefulWidget {
  TextEditingController? creditnum,
      cvv,
      ex,
      model,
      color,
      carnum,
      cardescribe,
      cartype;
  RegisterScreen(
      {this.carnum,
      this.model,
      this.color,
      this.cartype,
      this.ex,
      this.cardescribe,
      this.creditnum,
      this.cvv});

  //ApiProvide ap=ApiProvide();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController confirm = TextEditingController();
  // TextEditingController carCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  bool Show_Pass = true;

  String? name, age, email, phone, details;
  int? credit;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Image.asset('assets/pana.png'),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 32,
                      color: borderColor,
                      fontFamily: 'comfortaa',
                    ),
                  ),
                ],
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
                  print(name);
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
                    return "Password must not be empty";
                  } else if (value.length < 6) {
                    return "Password is too short";
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
                    return "Password must not be empty";
                  } else if (value.length < 6) {
                    return "Password is too short";
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
                        /*await ApiProvide().UserRegisteration(
                            fullname: nameCont.text,
                            age: ageCont.text,
                            email: emailCont.text,
                            password: passCont.text,
                            passwordConfirm: confirm.text,
                            phone: phoneCont.text,
                            /*carnum: this.widget.carnum!.text,
                            cvv: this.widget.cvv!.text,
                            color: this.widget.color!.text,
                            cardnum: this.widget.creditnum!.text,
                            cardescription: this.widget.cardescribe!.text,
                            cartype: this.widget.cartype!.text,
                            model: this.widget.model!.text,
                            exdate: this.widget.ex!.text  */
                            );

                         */
                        await ApiProvide().UserRegisteration(
                          fullname: nameCont.text,
                          age: ageCont.text,
                          email: emailCont.text,
                          password: passCont.text,
                          passwordConfirm: confirm.text,
                          phone: phoneCont.text,
                            );
                        Navigator.of(context).push(MaterialPageRoute (
                          builder: (BuildContext context) => OTP(rg: regmodel(emailCont.text)),
                        ),);

                        await OTPprovider().sendcode(email: emailCont.text);
                      }
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
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        context: context,
        builder: (BuildContext context) {
          return Card_Details_Screen();
        });
  }
}
