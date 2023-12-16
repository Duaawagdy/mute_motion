import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/view/resgisterscreen.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
import 'package:provider/provider.dart';

import '../../resgisterscreen/provider/auth_provider.dart';
//import 'package:mutuemotion/home/presentation/view/widgets/custombutton.dart';

class CarDetailsScreen extends StatefulWidget {
  CarDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  String? type, color, describe;

  String? model, num;

  bool isloading = false;


  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    {
      return Consumer<AuthProvider>(builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Color(0xff003248),
            appBar: AppBar(
              title: Text(
                'Car Details',
                style: TextStyle(
                    fontSize: 25, fontFamily: 'Lato', color: Colors.white),
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 22,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Car Image',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'Lato', color: borderColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/Group 542.png')),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                    
                                  onChanged: (data) {
                                    type = data;
                                  },
                                  hintText: 'Car Type',
                                  cont: provider.typeCont,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                CustomTextField(
                                  onChanged: (data) {
                                    color = data;
                                  },
                                  hintText: 'Color',
                                  cont: provider.colorCont,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                CustomTextField(
                                  onChanged: (data) {
                                    model = data;
                                  },
                                  hintText: 'model',
                                  cont: provider.modelCont,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                CustomTextField(
                                  onChanged: (data) {
                                    num = data;
                                  },
                                  hintText: 'Car Num',
                                  cont: provider.numCont,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                CustomTextField(
                                  onChanged: (data) {
                                    describe = data;
                                  },
                                  hintText: 'Descirde Your Car',
                                  cont: provider.describeCont,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff003248),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: MaterialButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                    
                                          provider.typeCont.text;
                                          provider.colorCont.text;
                                          provider.modelCont.text;
                                          provider.numCont.text;
                                          provider.describeCont.text;
                                        }
                                        GoRouter.of(context).pop(
                                          RegisterScreen(),
                                        );
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Comfortaa',
                                            color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      );
    }
  }
}
