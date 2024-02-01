import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mute_motion/core/utils/offline.dart';
import 'package:mute_motion/core/utils/online.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class Orders_Screen extends StatefulWidget {
  const Orders_Screen({Key? key}) : super(key: key);

  @override
  State<Orders_Screen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<Orders_Screen> {
  bool isOffline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 20,
          left: 15,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LiteRollingSwitch(
                value: isOffline,
                width: 170,
                textOn: 'Online',
                textOff: 'Offline',
                textOnColor: Colors.white,
                colorOff: Color(0xffFE5C5D),
                colorOn: Color(0xff097607),
                iconOff: Icons.wifi_off,
                // iconOn: Icons.wifi,
                textSize: 22.0,
                animationDuration:Duration(milliseconds: 600),
                onChanged: (value) {
                  setState(() {
                    isOffline = value;
                  });
                }, onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
              ),
              isOffline ? Online() : Offline(),
            ],
          ),
        ),
      ),
    );
  }
}
