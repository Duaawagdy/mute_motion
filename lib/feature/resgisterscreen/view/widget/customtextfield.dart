import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.lableText,
      this.icon,
      this.cont,
      this.onTap});
  String? hintText;
  String? lableText;
  final IconData? icon;
  //final IconData ?sufficon;
  Function(String)? onChanged;
  Function()? onTap;
  TextEditingController? cont;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: cont,
        validator: (value) {
          if (value!.isEmpty) {
            return " must not be empty";
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: lableText,
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
            suffixIconColor: borderColor,
            labelStyle: TextStyle(color: borderColor),
            suffixIcon: IconButton(
              onPressed: () {
                onTap;
              },
              icon: Icon(
                icon,
              ),
            )));
  }
}
