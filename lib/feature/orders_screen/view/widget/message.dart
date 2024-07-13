import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/map/provider/map_provider.dart';
import 'package:mute_motion/feature/map/view/map_screen.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class messagerequest extends StatelessWidget {
   messagerequest({super.key,this.orderId,this.endtpoints,this.startpoints,this.cost,this.startlocationname,this.endlocationname,this.passengerid});
String?orderId;

   List<double> ?startpoints;
   List<double> ?endtpoints;
   String?cost;
   String?startlocationname;
   String?endlocationname;
   String?passengerid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        backgroundColor: Color(0xff003248),
        content: Container(
          width: 350.w,
          height: 180.h,
          child: Column(
            children: [
              Text(
                'Request Accepted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF8F8F8),
                  fontSize: 24.sp,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w700,
                  //height: 0.03,
                  letterSpacing: 1.w,
                ),
              ),
              SizedBox(
                height: 13.h,
              ),
              Expanded(
                child: Text(
                  'Passenger Accept your ride  '
                  'request, get contact now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF8F8F8),
                    fontSize: 15.sp,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.w,
                  ),
                ),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: MaterialButton(
                        onPressed: () {
                          OrderRepoImpl().responedToOrder(orderId!, true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RouteScreen()),
                          );
                       Provider.of<MapProvider>(context, listen: false);

                          setvalues();
                          //GoRouter.of(context).push('/chat');
                        },
                        child:  Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Comfortaa',
                              color: Color(0xff003248)),
                        )),
                  ),
                  SizedBox(
                    width: 23.w,
                  ),
                  Container(
                    height: 50.h,
                    width: 120.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 2.50.w, color: Color(0xFFF8F8F8)),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: MaterialButton(
                        onPressed: () {
                          OrderRepoImpl().responedToOrder(orderId!, false);

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: 'Comfortaa',
                              color: Colors.white),
                        )),
                  )
                ],
              )
            ],
          ),
        ));

  }
   Future<void> setvalues()async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('passengerId', passengerid!);
     if (orderId != null) prefs.setString('orderId', orderId!);
     if (startpoints != null) {
       prefs.setDouble('startpointslat', startpoints![0]);
       prefs.setDouble('startpointslon', startpoints![1]);
     }
     if (endtpoints != null) {
       prefs.setDouble('endtpointslat', startpoints![0]);
       prefs.setDouble('endtpointslon', startpoints![1]);

     }
     if (cost != null) prefs.setString('cost', cost!);
     print(cost);
     if (startlocationname != null) prefs.setString('startlocationname', startlocationname!);
     if (endlocationname != null) prefs.setString('endlocationname',endlocationname! );


   }
}
