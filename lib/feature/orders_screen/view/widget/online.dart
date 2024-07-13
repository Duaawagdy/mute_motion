import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';
import 'package:mute_motion/feature/orders_screen/view/widget/custemrequest.dart';
import 'package:mute_motion/feature/orders_screen/view_model/orderModel.dart';

// ... imports

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 20.w, top: 15.h, ),
        child: FutureBuilder<PendingOrdersResponse>(
          future: OrderRepoImpl().fetchNewestOrder(),
          builder: (BuildContext context, AsyncSnapshot<PendingOrdersResponse> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final pendingOrders = snapshot.data!.pendingOrders;

              return pendingOrders.isEmpty
                  ? NoOrder()
                  : Column(
                children: List.generate(pendingOrders.length, (index) {
                  final pendingOrder = pendingOrders[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      trassportrequest(
                        requestNumber: index + 1,
                        passengerName: "norhan ahmed", // Use passenger name from data
                        timeDate: '10:03 - 26 April', // Replace with actual time and date from data
                        sourceLocation: pendingOrder.locationName,
                        destinationLocation: pendingOrder.destinationName,
                        cost: pendingOrder.cost, // Convert cost to string
                        orderId: pendingOrder.orderid,

                        startpoints: pendingOrder.startLocation.coordinates,
                        endtpoints: pendingOrder.destination.coordinates,
                         passengerId: pendingOrder.passenger,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  );
                }),
              );
            }
            return Center(child: CircularProgressIndicator(color: Color(0xff003248),));
          },
        ),
      ),
    );
  }
}

class NoOrder extends StatelessWidget {
  const NoOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 250),
      child: Text('You don\'t have order yet',
        style: TextStyle(fontSize: 26.sp,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
    );
  }
}

