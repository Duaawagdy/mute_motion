import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../resgisterscreen/view/resgisterscreen.dart';

class Card_Details_Screen extends StatefulWidget {
  const Card_Details_Screen({super.key});

  @override
  State<Card_Details_Screen> createState() => _Card_Details_ScreenState();
}

class _Card_Details_ScreenState extends State<Card_Details_Screen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: 466,
        width: 430,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Text(
                    'Setup Credit Card',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lato',
                        color: Color(0xff003248)),
                  ),
                  Divider(
                    color: Color(0x88101010),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text(
                        'Card Types Accepted',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            color: Color(0xff003248)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.asset('assets/Vector.png'),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          height: 36,
                          width: 49,
                          child: Image.asset('assets/Group 450.png')),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Card Number',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Comfortaa',
                        color: Color(0xff003248)),
                  ),
                  TextFormField(
                    controller: provider.cardNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Card Number must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Color(0xff003248)),
                          ),
                          Container(
                            width: 150, // Set a finite width
                            child: TextFormField(
                              controller: provider.expiryDateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Expiry Date must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVV',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Color(0xff003248)),
                          ),
                          Container(
                            width: 150, // Set a finite width
                            child: TextFormField(
                              controller: provider.cvvController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "CVV must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'We will securely store this card for a faster payment experience',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Comfortaa',
                        color: Color(0xff003248)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff003248),
                        borderRadius: BorderRadius.circular(15)),
                    child: MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // await ApiProvide().CreditDetails(cardnum: cardNumberController.text,cvv: cvvController.text,exdate: expiryDateController.text);

                            GoRouter.of(context).pop(
                              RegisterScreen(),
                            );
                          }
                        },
                        child: const Text(
                          "Add Card",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Comfortaa',
                              color: Colors.white),
                        )),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
