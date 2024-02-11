import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/map/view/widgets/custembutten.dart';
import 'package:mute_motion/feature/map/view/widgets/cutemfield.dart';
import 'package:mute_motion/feature/sidebar/presentation/view/sidebar.dart';

class map extends StatefulWidget{
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  //final Completer<GoogleMapController> controller =
  //Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.533093683132158, 31.617954809805735),
    zoom: 17,
  );
  GoogleMapController ?googleMapController;
  Set<Marker> markers={};
void initState(){

  googleMapController;
initMarkers();
  super.initState();
}
void dispose(){
  googleMapController?.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap:(){GoRouter.of(context).push('/chat');},
                child: CircleAvatar(backgroundColor:  Color(0xff003248),radius: 25,child: Icon(Icons.message))),
            SizedBox(height: 10,),
            GestureDetector(onTap: (){GoRouter.of(context).push('/search');},child: CircleAvatar(backgroundColor:  Color(0xff003248),radius: 25,child: Icon(Icons.location_searching)))
          ],
        ),
        drawer: NavDrawer(),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: Stack(
    children: <Widget>[ GoogleMap(
      markers: markers,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            googleMapController=controller;
            initMapStyle();
          }
        ),
    Positioned(
        bottom: 0,

        child:Container(
            padding: EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width,
          child: setLocationWidget(googleMapController: googleMapController),
          //height: 346,

          decoration:const BoxDecoration(
              color: Color(0xff003248),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),)
    )
    ],
      )


    );
  }

  Future<void> initMapStyle() async {
 var roadcolor=await DefaultAssetBundle.of(context).loadString('lib/feature/map/assets/map_style/road_color_gray.json');
 googleMapController?.setMapStyle(roadcolor);
  }

  void initMarkers() {
  var marker =Marker(markerId: MarkerId('1'),position:LatLng(30.533093683132158, 31.617954809805735) );
 markers.add(marker);
  }

}

class setLocationWidget extends StatelessWidget {
  const setLocationWidget({
    super.key,
    required this.googleMapController,
  });

  final GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 18,),
        Text('Set your loction',textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 21, fontFamily:'comfortaa', color: Color(
                0xffffffff))),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29.0),
          child: Divider(color: Color(0xFFFFFFFF),),
        ),
        SizedBox(height: 24,),
        custemlabel(icon: Icons.location_on_sharp, Place: 'Elzamalk - Egypt'),
        SizedBox(height: 24,),
        custemlabel(icon: FontAwesomeIcons.locationArrow, Place: 'Cairo Festival Mall - Nasr City'),
        SizedBox(height: 24,),
        //TextField(e),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(children: [
            Container(
              height: 51,
              width: 180,
              decoration: BoxDecoration(
                  color: const Color(0xffffffff) ,
                  borderRadius: BorderRadius.circular(15)),
              child: custembuttenconfirm(googleMapController: googleMapController,),
            ),
            SizedBox(width: 20,),
            custembuttensearch()
          ],),
        )
      ],
    );
  }
}
