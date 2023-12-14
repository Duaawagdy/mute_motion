import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/view/resgisterscreen.dart';
import 'package:mute_motion/feature/resgisterscreen/view/widget/customtextfield.dart';
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
  TextEditingController typeCont = TextEditingController();
  TextEditingController colorCont = TextEditingController();
  TextEditingController modelCont = TextEditingController();
  TextEditingController numCont = TextEditingController();
  TextEditingController describeCont = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    {
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
              left: 15,
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
                      height: 6,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/Group 542.png')),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              onChanged: (data) {
                                type = data;
                              },
                              hintText: 'Car Type',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              onChanged: (data) {
                                color = data;
                              },
                              hintText: 'Color',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              onChanged: (data) {
                                model = data;
                              },
                              hintText: 'model',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              onChanged: (data) {
                                num = data;
                              },
                              hintText: 'Car Num',
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            CustomTextField(
                              onChanged: (data) {
                                describe = data;
                              },
                              hintText: 'Descirde Your Car',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xff003248),
                                  borderRadius: BorderRadius.circular(20)),
                              child: MaterialButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      //  await ApiProvide().CarDetails(cartype: typeCont.text,color: colorCont.text,model: modelCont.text,carnum: numCont.text,cardescription: describeCont.text);
                                      typeCont.text;
                                      colorCont.text;
                                      modelCont.text;
                                      numCont.text;
                                      describeCont.text;
                                    }
                                    print(typeCont.text);
                                    print(colorCont.text);
                                    print(modelCont.text);
                                    print(numCont.text);
                                    print(describeCont.text);
                                    GoRouter.of(context).pop(
                                      RegisterScreen(
                                        cartype: typeCont,
                                        color: colorCont,
                                        carnum: numCont,
                                        cardescribe: describeCont,
                                      ),
                                    );
                                    String typee = typeCont.text;
                                    String color = colorCont.text;
                                    String carnum = numCont.text;
                                    String decribetion = describeCont.text;
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
  }
}
