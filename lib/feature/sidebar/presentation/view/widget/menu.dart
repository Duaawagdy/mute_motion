import 'package:flutter/material.dart';
import 'package:mute_motion/core/utils/constant.dart';
class menuitem extends StatelessWidget{
  const menuitem({super.key, required this.itemname, required this.icon, this.onpressed});
  final String itemname;
final IconData icon;
   final Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
          color: borderColor,
        ),
        trailing: IconButton(
          onPressed: onpressed,
          icon: Icon(
            Icons.play_arrow_rounded,
            size: 20,
            color: borderColor,
          ),
        ),
        title: Text(
          itemname,
          style: TextStyle(
            fontSize: 15,
            color: borderColor,
            fontFamily: 'Comfortaa'
          ),
        ),
      ),
    );
  }

}