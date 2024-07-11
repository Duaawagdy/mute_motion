import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/feature/orders_screen/view/widget/message.dart';

import '../../../map/view/map_screen.dart';

class trassportrequest extends StatelessWidget {
  trassportrequest(
      {super.key,
      this.requestNumber,
      this.passengerName,
      this.timeDate,
      this.sourceLocation,
      this.destinationLocation,
      this.cost,
      this.orderId,
        this.startpoints
        ,this.endtpoints
      });
  int? requestNumber;
  String? passengerName;
  String? timeDate;
  String? sourceLocation;
  String? destinationLocation;
  String? cost;
  String? orderId;
  List<double> ?startpoints;
  List<double> ?endtpoints;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: Color(0xffF0EFEF),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              spreadRadius: 2.r,
            )
          ]),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.h),
                  padding: EdgeInsets.all(3).w,
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Color(0xff003248),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${requestNumber}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'lato',
                          color: Colors.white,
                        )),
                  ),
                ),
                Text(
                  "Transport Request",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Comfortaa',
                      color: Color(0xff003248)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 10.w,
              ),
              Text(passengerName!,
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 10.w,
              ),
              Text(sourceLocation!,
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.locationArrow),
              SizedBox(
                width: 10.w,
              ),
              Text(destinationLocation!,
                  style: TextStyle(fontSize: 15, fontFamily: 'Comfortaa'))
            ],
          ),
          Divider(
            thickness: 2.h,
            height: 30.h,
            indent: 10.w,
            endIndent: 5.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Expected Cost: ',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa'),
              ),
              Text(
                cost!,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xff087405),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa'),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
            width: (double.infinity).w,
            decoration: BoxDecoration(
                color: const Color(0xff003248),
                borderRadius: BorderRadius.circular(15.r)),
            child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return messagerequest(
                          orderId: orderId,
                          startpoints: startpoints,
                          endtpoints: endtpoints,
                          startlocationname: sourceLocation,
                          endlocationname: destinationLocation,
                        );



                      });


                },
                child: Text(
                  "Take It Now",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
