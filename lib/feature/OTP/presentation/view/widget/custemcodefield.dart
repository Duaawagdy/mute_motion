import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class custemcodefield extends StatelessWidget {
   custemcodefield({super.key, required this.codecontroller,  this.focusNode, this.onChanged});
  final TextEditingController codecontroller;
   FocusNode ?focusNode;
   Function(String) ?onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xD9D9D9),
      width: 80, height: 78,
      decoration: BoxDecoration(
          color: Color(0xD9D9D9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 2)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: TextFormField(
          onChanged:onChanged ,
          focusNode: focusNode,
          controller: codecontroller, maxLength: 1,
          validator: (value) {
          if (value!.isEmpty) {
            return " empty! ";
          }
          return null;
        },
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
