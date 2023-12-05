import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(4),
                                    padding: EdgeInsets.all(3),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xff003248),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text('1',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'lato',
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  Text(
                                    "Transport Request",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Comfortaa',
                                        color: Color(0xff003248)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Yara Afifi',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Comfortaa'))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('9:20 - 25 April ',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Comfortaa'))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Elfath street -Nasr city - Cairo',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Comfortaa'))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Salah Elden street - Elzamalek - Cairo',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'Comfortaa'))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
