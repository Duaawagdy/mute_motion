import 'package:flutter/material.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';
import 'package:mute_motion/feature/orders_screen/view/widget/custemrequest.dart';
//import 'package:mute_motion/feature/orders_screen/model/pending_order.dart';
import 'package:mute_motion/feature/orders_screen/view_model/orderModel.dart';

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 20, top: 15, bottom: 15),
        child: FutureBuilder<PendingOrdersResponse>(
          future: OrderRepoImpl().fetchNewestOrder(),
          builder: (BuildContext context, AsyncSnapshot<PendingOrdersResponse> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final pendingOrders = snapshot.data!.pendingOrders;
              //print(pendingOrders);
              return pendingOrders.isEmpty? NoOrder():Column(
                children: List.generate(pendingOrders.length, (index) {
                  final pendingOrder = pendingOrders[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      trassportrequest(
                        requestNumber: index + 1,
                        passengerName: 'Yara Afifi',
                        timeDate: '10:03 - 26 April',
                        sourceLocation: pendingOrder.locationName,
                        destinationLocation: pendingOrder.destinationName,
                        cost: pendingOrder.cost ?? 'N/A',
                        orderId: pendingOrder.orderid,
                      ),
                      SizedBox(
                        height: 20,
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
        style: TextStyle(fontSize: 26,fontFamily: 'Comfortaa', color: Color(0xff003248)),),
    );
  }
}


