import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mute_motion/core/utils/AppRouter.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/widget/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menubody extends StatelessWidget{
    menubody({super.key});
  approuter ap=approuter();

  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 14.h,
        left: 19.w,
        right: 19.w
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          )
      ),
    child: ListView(children: [
      menuitem(itemname: 'Map',icon: Icons.map_outlined,onpressed: (){GoRouter.of(context).push('/map');
        },),
      Padding(
        padding:  EdgeInsets.only(left: 18.0.w,right: 18.w,top: 0.h),
        child: Divider(color: Colors.grey,thickness: 1.5.w,),
      ),
      menuitem(itemname: 'About Us',icon: Icons.supervised_user_circle,onpressed: (){GoRouter.of(context).push('/aboutus');}),
      Padding(
        padding:  EdgeInsets.only(left: 18.0.w,right: 18.w,top: 0.h),
        child: Divider(color: Colors.grey,thickness: 1.5.w,),
      ),
      menuitem(itemname: 'Log Out',icon: Icons.logout,onpressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        approuter.clearAndNavigate(context, '/loginview');}),
      Padding(
        padding: EdgeInsets.only(left: 18.0.w,right: 18.w,top: 0.h),
        child: Divider(color: Colors.grey,thickness: 1.5.w,),
      ),
      SizedBox(height: 150.h,),
    ],
    ),
    );
  }

}