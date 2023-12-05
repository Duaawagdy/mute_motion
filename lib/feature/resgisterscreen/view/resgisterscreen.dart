
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/carddetials/view/card_details.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/custemfield.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/custombutton.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
import 'package:mute_motion/core/utils/constant.dart';





class RegisterScreen extends StatefulWidget{
 RegisterScreen ({ Key?key}):super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController creditCont = TextEditingController();
  TextEditingController carCont = TextEditingController();

  String? name,email,phone,details;
  int? age,credit;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kprimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(

          key: formKey,
          child: ListView(

            children: [
              //  SizedBox(height: 120,),

              Container(

                  height: 150,
                  width: 150,

                  child:
                  Image.asset('assets/pana.png')),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome',
                    style: TextStyle(
                      fontSize: 32,
                      color:borderColor,
                      fontFamily:'comfortaa',
                    ),
                  ),

                ],
              ),
              Text('Please Enter your Info',
                   textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:20,
                  color: borderColor,
                  fontFamily:'comfortaa',
                ),
              ),
              SizedBox(height: 20,),
              // Spacer(flex:1 ,),
              Row(

                children: [
                  Text(' Register',
                    style: TextStyle(
                      fontSize: 24,
                      color: borderColor,
                      fontFamily:'comfortaa',
                    ),
                  ),
                ],
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
                  age = data as int?;
                },
                icon: Icons.calendar_month,
                hintText: 'Age',
              ),
              SizedBox(
                height: 18,
              ),
              CustomTextField(
                cont: emailCont,
                onChanged: (data) {
                  email = data;
                },
                hintText: 'Email',
                icon:Icons.email_outlined,
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

              CustomField(onTap: (){
                buildShowModalBottomSheet(context);
              }, hintText: 'Add credit card',
                icon: Icons.chevron_right,),
              SizedBox(
                height: 18,
              ),
              CustomField(
                onTap: (){GoRouter.of(context).push('/cardetails');
                  print('done');},
                //cont: carCont,
                hintText: 'Add Car Details',
                icon: Icons.chevron_right,
              ),
              SizedBox(
                height: 33,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff003248),
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        nameCont.text;
                        emailCont.text;
                        phoneCont.text;
                        ageCont.text;
                        creditCont.text;
                        carCont.text;
                      }

                      GoRouter.of(context).push('/OTP');
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
                    )),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already have an account',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  GestureDetector(onTap: () {
                    Navigator.pop(context);
                  },
                    child: Text('  Login',
                      style: TextStyle(
                          color: Color(0xffc7EDE6)
                      ),),
                  ),
                ],
              ),
              //Spacer(flex: 1,)
            ],),
        ),
      ),

    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),context: context, builder: (BuildContext context){
                return Card_Details_Screen();
              });
  }

}