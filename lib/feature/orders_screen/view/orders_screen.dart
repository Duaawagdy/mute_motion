import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core//utils/offline.dart';
import 'package:mute_motion/core//utils/online.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';
class Orders_Screen extends StatefulWidget {
  const Orders_Screen({super.key});

  @override
  State<Orders_Screen> createState() => _Orders_ScreenState();
}

class _Orders_ScreenState extends State<Orders_Screen> {
  int _buttonIndex = 0;
  final _StatusWidget = [
    //Completed Widgets
    Offline(),
    //Canseled Widgets
    Online(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: NavDrawer(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        title: Text('Orders',style: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.white),),
        //leading: IconButton(onPressed:(){} ,icon: Icon(FontAwesomeIcons.bars,color: Colors.white,)),
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
                Container(
                  width: MediaQuery.of(context).size.width/2.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border:_buttonIndex == 0? Border.all(color: Color(0xff760F07)):Border.all(color: Color(0xff097607))
                ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 0? Color(0xff760F07):Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: _buttonIndex == 0? Text("Offline",
                        style: TextStyle(
                        color:Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                        ): Text(''),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _buttonIndex = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                        decoration: BoxDecoration(
                          color: _buttonIndex == 1? Color(0xff097607):Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:  _buttonIndex == 1? Text("Online",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        ),
                        ): Text(''),
                      ),
                    ),
                    
                  ],
                            ),
                ),
                _StatusWidget[_buttonIndex],
              ],
            ),
          ),
      ),
    );
  }
}