import 'package:flutter/material.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class Notification_Screen extends StatelessWidget {
  const Notification_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color:  Color(0xff003248)),
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 21, fontFamily: 'Lato', color: Color(0xff003248)),
        ),

        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hassan, you have a new order',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 5,),
              Text(
                'Check out your newest orders to take one of them',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 5,),
              Text(
                '6:00 pm - 16 March',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.black38,
                      thickness: 2,
                      height: 30,
                      
                    ),
              SizedBox(height: 10,),
              Text(
                'Welcome to our team, Hassan!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 5,),
              Text(
                'We are happy to join with us, get your orders now.',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 5,),
              Text(
                '8:00 pm - 15 March',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Comfortaa',
                    color: Color(0xff003248)),
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.black38,
                      thickness: 2,
                      height: 30,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
