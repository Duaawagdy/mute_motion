import 'dart:async';
import 'package:mute_motion/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class mymap extends StatefulWidget{
  const mymap();
  @override
  State<mymap> createState() => _mymapState();
}

class _mymapState extends State<mymap> {
  late GoogleMapController ?googleMapController;
  final Completer<GoogleMapController> _mapcontroller=
  Completer<GoogleMapController>();
  Location _locationcontroller=new Location();
  LatLng ?_currentlocation=null;
  Map<PolylineId,Polyline>polylines={};
  static const LatLng _destinationlocatio= LatLng(30.541920853284697, 31.678156380256656);
  static const LatLng _userlocation= LatLng(30.538064272855628, 31.662419559020925);
@override
  void initState() {

    getLocationUpdated().then((_) => {
      getpolylinepoints().then((coordanites) => {
generatepolyline(coordanites)      })
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(body:
       _currentlocation==null?Center(child: Text('loading...'),):
   GoogleMap
     (
     onMapCreated: (
             (GoogleMapController controller){
                 _mapcontroller.complete(controller);
                 googleMapController=controller;
                 initMapStyle();
             }
     ),
     initialCameraPosition:
   CameraPosition(target: _destinationlocatio,zoom: 10),
   markers: {
     Marker(markerId:
     MarkerId('currentlocation'),
         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),position:_currentlocation!),
       Marker(markerId:
       MarkerId('destinationlocation'),
         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),position: _destinationlocatio),
     Marker(markerId:
     MarkerId('userlocation'),
         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),position: _userlocation)
   },
     polylines: Set<Polyline>.of(polylines.values),
   ),
   );
  }
  Future<void> initMapStyle() async {
    var roadcolor=await DefaultAssetBundle.of(context).loadString('lib/feature/map/assets/map_style/road_color_gray.json');
    googleMapController?.setMapStyle(roadcolor);
  }
  //move camerapostin on map while user moving
  Future<void> cameratopostion(LatLng pos)async{
final GoogleMapController controller= await _mapcontroller.future;
CameraPosition _newcamerapostion =new CameraPosition(target: pos,zoom: 16);
await controller.animateCamera(CameraUpdate.newCameraPosition(_newcamerapostion));
  }
  Future<void> getLocationUpdated()async {
    bool _serverEnable;
    PermissionStatus _permissionGranted;
    _serverEnable =await _locationcontroller.serviceEnabled();
    if(_serverEnable){
      _serverEnable= await _locationcontroller.requestService();
    }else{
      return;}
    _permissionGranted = await _locationcontroller.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationcontroller.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationcontroller.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude!=null&&currentLocation.longitude!=null){
        setState(() {
          _currentlocation=LatLng(currentLocation.latitude!,currentLocation.longitude!);
          //print(currentLocation);
          cameratopostion(_currentlocation!);
         // _cameraTopotion( LatLng);
          //var marker =Marker(markerId: MarkerId('current location'),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),position: currentlocation!);
          //markers.add(marker);
        });
      }
    });

  }
  Future<List<LatLng>> getpolylinepoints() async {
    List<LatLng> polylinecoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult Result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAPmuYF0lap3-EZk1Vfz5rj_DWXOqB2X08',  // Replace with your actual API key
        PointLatLng(_userlocation.latitude, _userlocation.longitude),
        PointLatLng(_destinationlocatio.latitude, _destinationlocatio.longitude),
        travelMode: TravelMode.driving,
      );

      if (Result.points.isNotEmpty) {
        Result.points.forEach((PointLatLng point) {
          polylinecoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print('No polyline points found.');
      }
    } catch (e) {
      print('Error fetching polyline points: $e');
    }

    setState(() {});

    return polylinecoordinates;
  }

  Future<void> generatepolyline(List<LatLng>polylinecoordinate) async {
   print('Polyline Coordinates: $polylinecoordinate');

   PolylineId id=PolylineId('poly');
Polyline polyline=
Polyline(
    polylineId: id,color:Colors.black,
    points: polylinecoordinate,width: 8 );
setState(() {
  polylines[id]=polyline;
});
  }
}