import 'package:flutter/material.dart';

import 'package:mute_motion/core/utils/constant.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField ({super.key,this.onChanged, this.hintText, this.icon,this.cont,this.onTap});
  String? hintText;
  final IconData ?icon;
  //final IconData ?sufficon;
  Function(String)? onChanged;
  Function()? onTap;
  TextEditingController? cont ;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(

        controller: cont,
        validator:
            (value) {
          if (value!.isEmpty) {
            return " must not be empty";
          }
          return null;
        },
        onChanged:onChanged ,
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
            suffixIcon: IconButton(
              onPressed: () {
                   onTap;
              },
              icon: Icon(
                icon,
              ),

            )
        ) );


  }




}