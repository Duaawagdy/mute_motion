import 'package:flutter/material.dart';

class custembutten extends StatelessWidget{
    custembutten({this.onPressed,required this.text});
    final String text;
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
          child:  Text( text,
            style: TextStyle(fontSize: 22,fontFamily: 'Comfortaa', color: Colors.white),
          )),
    );
  }
}