
 import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class custembuttensearch extends StatelessWidget {
  const custembuttensearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      width: 181,
      decoration:ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2.50, color: Color(0xFFF8F8F8)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: MaterialButton(
          onPressed: (){GoRouter.of(context).push('/search');},
          child: const Text(
            "Search",
            style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa', color: Colors.white),
          )),
    );
  }
}
 class custembuttenconfirm extends StatelessWidget {
    custembuttenconfirm({
     super.key,
     required this.googleMapController,
   });
late  bool isconfirm;
   final GoogleMapController? googleMapController;
get confirm{
  return isconfirm;
  print(isconfirm);
}
   @override
   Widget build(BuildContext context) {

     return MaterialButton(
         onPressed: (){
           isconfirm=true;
           print(isconfirm);
           CameraPosition cameraPosition=new CameraPosition(target: LatLng(30.37546425051631, 31.544629200580466),zoom: 16);
           googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
         },
         child: const Text(
           "Confirm",
           style: TextStyle(fontSize: 20,fontFamily: 'Comfortaa', color: Color(0xff003248)),
         ));
   }
 }