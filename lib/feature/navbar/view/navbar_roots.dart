import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion/feature/my_orders/view/my_orders_screen.dart';
import 'package:mute_motion/feature/orders_screen/view/orders_screen.dart';

import '../../signs/presentation/view/signs.dart';
import '../../traslator/presentation/view/translator_screen.dart';

class Navbar_Roots extends StatefulWidget {
  const Navbar_Roots({super.key});

  @override
  State<Navbar_Roots> createState() => _Navbar_RootsState();
}

class _Navbar_RootsState extends State<Navbar_Roots> {
  int _selectedIndex = 0;
  final _screens = [
    //Orders Screen
    Orders_Screen(),
    //My_OrdersScreen
    My_Orders(),
    //Sign Screen
    signs(),
    //Translator Screen
    Translator_Screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          iconSize: 30,
          backgroundColor: Color(0xff003248),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: "My Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sign_language),
              label: "Signs",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "Translator",
            ),
          ],
        ),
      ),
    );
  }
}
