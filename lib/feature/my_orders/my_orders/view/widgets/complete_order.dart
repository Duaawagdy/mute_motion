import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mute_motion/core/utils/constant.dart';

class complete_order extends StatelessWidget {
  const complete_order({
    super.key,
    required this.req,
    required this.driverName,
    required this.rate,
    required this.destination,
    required this.psg_loc,
    required this.paymentMethod,
    required this.Cost,
  });
  final String req;
  final String driverName;
  final String rate;
  final String destination;
  final String psg_loc;
  final String paymentMethod;
  final String Cost;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330.w,
      height: 324.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Color(0xff003248),
                child: Icon(Icons.check, color: Colors.white, size: 30.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Transport Request",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10.w),
                  Text(
                    "Norhan Ahmed",
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10.w),
                  Text(
                    psg_loc,
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(FontAwesomeIcons.locationArrow),
                  SizedBox(width: 10.w),
                  Text(
                    destination,
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: 10.w),
                  Text(
                    "Payment Method: $paymentMethod",
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(
                thickness: 2,
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cost: ',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa'),
                  ),
                  Text(
                    Cost,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: borderColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
