import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
class My_Orders extends StatefulWidget {
  const My_Orders({super.key});

  @override
  State<My_Orders> createState() => _My_OrdersState();
}

class _My_OrdersState extends State<My_Orders> {
  int Num_Orders = 0;
    List orders = [
    "No. Orders: 0",
    "Requests: 5",
    "Income: 0",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My Orders',style: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding:const EdgeInsets.only(
            top: 20,
            left: 15,
          ),
          decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  )
                  ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: ListView.builder(
                    shrinkWrap:true,
                    scrollDirection: Axis.horizontal,
                    itemCount: orders.length,
                    itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                      padding: EdgeInsets.symmetric( horizontal:25 ),
                      decoration: BoxDecoration(
                        color: Color(0xff263238),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 4,
                              ),
                            ]
                      ),
                      child: Center(
                        child: Text(orders[index],
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Comfortaa',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  ),
                ),
              ],
            ),
          ),
    ));
  }
}