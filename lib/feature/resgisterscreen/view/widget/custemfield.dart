import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';

class CustomField extends StatelessWidget {
  CustomField ({super.key, this.hintText, this.icon,this.cont,this.onTap});
  String? hintText;
  final IconData ?icon;

  Function()? onTap;
  TextEditingController? cont ;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        decoration:
        InputDecoration(
            hintText: hintText,
            labelText: hintText,
            hintStyle: TextStyle(

              color: borderColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),

            //icon: GestureDetector(
            //  child: Icon(
            // icon,
            //size: 22,
            //),
            //),
            suffixIcon:  GestureDetector(
              onTap: onTap,
              child: Icon(
                  icon,
                ),
            ),

            )

    );}}