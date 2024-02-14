import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/profile/view/profile_item.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/custombutton.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          //alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 80),
                //height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      '128 Reviews',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 30, left: 10, right: 22, bottom: 5),
                        height: 110,
                        width: 350,
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        decoration: const BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Car Type:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'color:       Model:   ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '(automatic-comfort-4 seats)',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Lato',
                                          color: Colors.white),
                                    ),
                                  ]),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset('assets/car 1.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Profile_item(text: 'Name'),
                              SizedBox(
                                height: 6,
                              ),
                              Profile_item(text: 'Email'),
                              SizedBox(
                                height: 6,
                              ),
                              Profile_item(text: 'Phone'),
                              SizedBox(
                                height: 6,
                              ),
                              Profile_item(text: 'Age'),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  right: 25,
                                ),
                                child: CustomButon(
                                  text: 'Save',
                                  onTap: () async {
                                    // if (formKey.currentState!.validate()) {
                                    //   nameCont.text;
                                    //   emailCont.text;
                                    //   phoneCont.text;
                                    //   ageCont.text;
                                    // }
                                  },
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/man.png'),
                )),
            Positioned(
              top: 123,
              right: 130,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xff003248),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
