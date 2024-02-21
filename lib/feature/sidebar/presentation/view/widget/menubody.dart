import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/AppRouter.dart';
import 'package:mute_motion/feature/map/view/map.dart';
import 'package:mute_motion/feature/map/view/mapbody.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menubody extends StatelessWidget{
   menubody({super.key});
  approuter ap=approuter();

  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding:const EdgeInsets.only(
        top: 15,
        left: 15,
      ),
      decoration:const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
    child: ListView(children: [
      /*menuitem(itemname: 'Orders',icon: Icons.receipt_outlined,onpressed: (){GoRouter.of(context).push('/orders');},),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'My Orders',icon: Icons.check_circle,onpressed: (){GoRouter.of(context).push('/myorders');}),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'signs',icon: Icons.sign_language,onpressed: (){GoRouter.of(context).push('/sign');},),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'Translator',icon: Icons.camera_alt,onpressed: (){GoRouter.of(context).push('/translation');}),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),

       */
      menuitem(itemname: 'Map',icon: Icons.map_outlined,onpressed: (){GoRouter.of(context).push('/map');
        },),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'notifications',icon: Icons.notifications_none,onpressed: (){GoRouter.of(context).push('/notification');}),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'About Us',icon: Icons.supervised_user_circle,onpressed: (){GoRouter.of(context).push('/aboutus');}),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
      menuitem(itemname: 'Log Out',icon: Icons.logout,onpressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        approuter.clearAndNavigate(context, '/loginview');}),
      Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18,top: 0),
        child: Divider(color: Colors.grey,thickness: 2,),
      ),
    ],
    ),
    );
  }

}