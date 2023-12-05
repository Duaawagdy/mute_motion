import 'package:flutter/material.dart';

class custembutten extends StatelessWidget{
  const custembutten({this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,

      width: 381,
      decoration: BoxDecoration(
          color: const Color(0xff003248),
          borderRadius: BorderRadius.circular(15)),
      child: MaterialButton(
          onPressed: onPressed,
          child: const Text(
            "Confirm",
            style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
          )),
    );
  }
}