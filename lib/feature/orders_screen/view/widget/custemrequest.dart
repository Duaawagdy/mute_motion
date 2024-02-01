import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/feature/orders_screen/view/widget/message.dart';

class trassportrequest extends StatelessWidget {
  const trassportrequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xffF0EFEF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            )
          ]),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4, right: 4, bottom: 4),
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
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 10,
              ),
              Text('Ahmed Magdy',
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
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
              Text('10:20 - 26 April ',
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
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
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.locationArrow),
              SizedBox(
                width: 10,
              ),
              Text('Salah Elden street - Elzamalek - Cairo',
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
            ],
          ),
          Divider(
            thickness: 2,
            height: 30,
            indent: 10,
            endIndent: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Expected Cost: ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa'),
              ),
              Text(
                'EGP 120',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff087405),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff003248),
                borderRadius: BorderRadius.circular(15)),
            child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return messagerequest();
                      });
                },
                child: const Text(
                  "Take It Now",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
