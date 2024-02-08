import 'package:flutter/material.dart';
import 'package:mute_motion/feature/orders_screen/view/widget/custemrequest.dart';

class Online extends StatelessWidget {
  const Online({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 20, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            trassportrequest(
              requestNumber: 1,
              passengerName: 'Yara Afifi',
              timeDate: '10:03 - 26 April',
              sourceLocation: 'Elftath street -Nasr city - Cairo',
              destinationLocation: 'Salah Elden street - Elzamalek - Cairo',
              cost: 'EGP 120',
            ),
            SizedBox(
              height: 20,
            ),
            trassportrequest(
              requestNumber: 2,
              passengerName: 'Ahmed Magdy',
              timeDate: '12:15 - 26 April',
              sourceLocation: 'Elftath street -Nasr city - Cairo',
              destinationLocation: 'Salah Elden street - Elzamalek - Cairo',
              cost: 'EGP 70',
            ),
            SizedBox(
              height: 20,
            ),
            trassportrequest(
              requestNumber: 3,
              passengerName: 'Naira Ahmed',
              timeDate: '01:30 - 27 April',
              sourceLocation: 'Elftath street -Nasr city - Cairo',
              destinationLocation: 'Salah Elden street - Elzamalek - Cairo',
              cost: 'EGP 100',
            ),
            SizedBox(
              height: 20,
            ),
            trassportrequest(
              requestNumber: 4,
              passengerName: 'Duaa Wagdy',
              timeDate: '11:30 - 29 April',
              sourceLocation: 'Elftath street -Nasr city - Cairo',
              destinationLocation: 'Salah Elden street - Elzamalek - Cairo',
              cost: 'EGP 90',
            ),
          ],
        ),
      ),
    );
  }
}
