import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/core/utils/constant.dart';

import 'package:mute_motion/feature/my_orders/my_orders/model/order.dart';
import 'package:mute_motion/feature/my_orders/my_orders/repo/complete_order_api.dart';
import 'package:mute_motion/feature/my_orders/my_orders/view/widgets/complete_order.dart';

import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class My_Orders extends StatefulWidget {
  const My_Orders({super.key});

  @override
  State<My_Orders> createState() => _My_OrdersState();
}

class _My_OrdersState extends State<My_Orders> {
  late Future<List<CompletedOrder>> futureCompletedOrders;

  @override
  void initState() {
    super.initState();
    futureCompletedOrders = fetchCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Orders History',
          style: TextStyle(
              fontSize: 24.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.only(top: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: FutureBuilder<List<CompletedOrder>>(
          future: futureCompletedOrders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Orders yet',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Comfortaa',
                          color: borderColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Start and make some orders!',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Comfortaa',
                          color: borderColor),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data![index];
                  return Column(
                    children: [
                      complete_order(
                        req: 'Transport Request',
                        driverName: 'Ahmed Fawzy',
                        rate: "3.2",
                        psg_loc: order.locationName,
                        destination: order.destinationName,
                        paymentMethod: order.paymentMethod,
                        Cost: order.cost,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
