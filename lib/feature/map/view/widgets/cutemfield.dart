import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class custemlabel extends StatelessWidget{
  const custemlabel({super.key, required this.icon, required this.Place});
final IconData icon;
final String Place;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 377,
      height: 48,
      child: TextFormField(
        readOnly: true,

        //enabled: false,

        decoration: InputDecoration(
          prefixIcon:Icon(

            icon,
            size: 18,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),

          // focusedBorder: buildOutlineInputBorder(),

          hintText:Place,

          hintStyle: TextStyle(color: Colors.white,fontSize: 18,fontFamily:'comfortaa')

        ),
      ),
    );
  }

}