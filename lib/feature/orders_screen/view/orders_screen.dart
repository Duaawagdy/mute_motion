import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:mute_motion/models/locationservice.dart';
import 'package:mute_motion/models/socketmannger.dart';
//import 'package:mute_motion/models/socketmannger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/offline.dart';
import 'widget/online.dart';

class Orders_Screen extends StatefulWidget {
  const Orders_Screen({Key? key}) : super(key: key);

  @override
  State<Orders_Screen> createState() => _OrdersScreenState();
}


class _OrdersScreenState extends State<Orders_Screen> {
  final LocationService _locationService = LocationService();
  bool isOnline = false;
  String? _token;

  @override
  void initState() {
    _locationService.checkLocationPermission();
    super.initState();

    SocketIOManager.instance.connect(); // Connect to socket server
    //_fetchToken();

    sendLocationUpdate();


  }
  @override
  void dispose() {
    SocketIOManager.instance.disconnect();
    super.dispose();
  }

  Future<String?> _fetchToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? useId = prefs.getString("userId");
    return useId;

  }

  Future<void> sendLocationUpdate() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("userId");
    print(token);
    if (token == null) {
      return;
    }

    Position position = await _locationService.getLocation();
    print(position);
    try {
      SocketIOManager.instance.emitDriverconnection(token);
      SocketIOManager.instance.emitDriverLocation(
        token,
        position,
      );
      print(isOnline);
    } catch (error) {
      print('Error sending location update: $error');

    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: (double.infinity).w,
        padding:  EdgeInsets.only(
          top: 20.h,
          left: 15.w,
        ),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LiteRollingSwitch(
                value: isOnline,
                width: 170.w,
                textOn: 'Online',
                textOff: 'Offline',
                textOnColor: Colors.white,
                colorOff: Color(0xff99b111e),
                colorOn: Color(0xff097607),
                iconOff: Icons.wifi_off,
                // iconOn: Icons.wifi,
                textSize: 22.0,
                animationDuration:Duration(milliseconds: 600),
                onChanged: (value) {
                  setState(()  {

                    isOnline = value;
                      OrderRepoImpl().onlinetoggle(isOnline);
                  });
                }, onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
              ),
              isOnline ? Online() : Offline(),
            ],
          ),
        ),
      ),
    );
  }
}
