import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/online.dart';
import 'package:mute_motion/feature/orders_screen/repo/order_repo_imp.dart';

class messagerequest extends StatelessWidget {
   messagerequest({super.key,this.orderId});
String?orderId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Color(0xff003248),
        content: Container(
          width: 350,
          height: 180,
          child: Column(
            children: [
              Text(
                'Request Accepted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF8F8F8),
                  fontSize: 24,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w700,
                  //height: 0.03,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Expanded(
                child: Text(
                  'Passenger Accept your ride  '
                  'request, get contact now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF8F8F8),
                    fontSize: 15,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(15)),
                    child: MaterialButton(
                        onPressed: () {
                          OrderRepoImpl().responedToOrder(orderId!, true);
                          GoRouter.of(context).push('/map');
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Comfortaa',
                              color: Color(0xff003248)),
                        )),
                  ),
                  SizedBox(
                    width: 23,
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 2.50, color: Color(0xFFF8F8F8)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: MaterialButton(
                        onPressed: () {
                          OrderRepoImpl().responedToOrder(orderId!, false);
                          Navigator.of(context).pop();


                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 18,
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
}
