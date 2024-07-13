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
            hintStyle: const TextStyle(
                color: Color(0xa6002634),fontFamily: 'comfortaa'),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0x9932394a)),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(16)),
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
