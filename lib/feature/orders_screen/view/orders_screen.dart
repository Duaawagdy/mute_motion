import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mute_motion/core/utils/offline.dart';
import 'package:mute_motion/core/utils/online.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
import 'package:mute_motion/models/locationservice.dart';
//import 'package:mute_motion/models/socketmannger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
   // super.initState();
   // _fetchToken(); // Fetch token on initialization
    //SocketIOManager.instance.connect(); // Connect to socket server
  }

  Future<void> _fetchToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    if (_token == null) {
      // Handle missing token (e.g., show error, redirect to login)
    }
  }

 // Future<void> sendLocationUpdate() async {
 //   if (_token == null) {
 //     return; // Avoid sending location update without token
 //   }
//
 //   Position position = await _locationService.getLocation();
 //   try {
 //     SocketIOManager.instance.emitDriverLocation(
 //       _token!,
 //       position,
 //     );
 //   } catch (error) {
 //     print('Error sending location update: $error');
 //     // Handle error appropriately (e.g., retry, notify user)
 //   }
 // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
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
