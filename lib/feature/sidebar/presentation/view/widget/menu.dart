import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          size: 25.sp,
          color: borderColor,
        ),
        trailing: IconButton(

          onPressed: onpressed,
          icon: Icon(

            Icons.play_arrow_rounded,
            size: 20.sp,
            color: borderColor,
          ),
        ),
        title: Text(
          itemname,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
            color: borderColor,
            fontFamily: 'Comfortaa'
          ),
        ),
      ),
    );
  }

}