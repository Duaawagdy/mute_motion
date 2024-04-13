import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:mute_motion/feature/resgisterscreen/provider/them_provider.dart';
import 'package:provider/provider.dart';
class modeItem extends StatefulWidget {
  const modeItem({super.key});

  @override
  State<modeItem> createState() => _modeItemState();
}

class _modeItemState extends State<modeItem> {

      bool status = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mode',style: TextStyle(
            fontSize: 25,
            color: borderColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comfortaa'
          ),),
          SizedBox(width: 20,),
          FlutterSwitch(
            width: 60.0,
            height: 35.0,
            switchBorder: Border.all(color: borderColor),
            value: status,
            borderRadius: 30.0,
            activeColor: Colors.black,
            padding: 8.0,
            showOnOff: false,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
          ],
        );
    });
  }
}