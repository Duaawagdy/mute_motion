import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class custemOTPbar extends StatelessWidget {
  const custemOTPbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              iconSize: 30,
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff003248),
              )),
          SizedBox(
            width: 80,
          ),
          Text(
            'OTP Verification',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff003248), fontFamily: 'Lato', fontSize: 22),
          ),
        ],
      ),
    );
  }
}
