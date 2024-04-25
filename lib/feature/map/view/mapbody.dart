import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
  const MyMap();
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController? googleMapController;
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  Location _locationController = Location();
  LatLng? _currentLocation;
  Map<PolylineId, Polyline> polylines = {};
  static const LatLng _destinationLocation = LatLng(30.541920853284697, 31.678156380256656);
  static const LatLng _userLocation = LatLng(30.538064272855628, 31.662419559020925);
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    initializeMap();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> initializeMap() async {
    await getLocationUpdates();
    await getPolylinePoints().then((coordinates) {
      generatePolyline(coordinates);
    });
  }

  Future<void> getLocationUpdates() async {
    _locationSubscription = _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          cameratoposition(_currentLocation!);
        });
      }
    });
  }

  Future<void> cameratoposition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC2Zz-eWGawv378cWw5Olhayx9SAX72Jko", // Replace with your actual API key
        PointLatLng(_userLocation.latitude, _userLocation.longitude),
        PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print('No polyline points found.');
      }
    } catch (e) {
      print('Error fetching polyline points: $e');
    }

    return polylineCoordinates;
  }

  void generatePolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? Center(child: Text('Loading...'))
          : GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
          googleMapController = controller;
          initMapStyle();
        },
        initialCameraPosition: CameraPosition(target: _destinationLocation, zoom: 10),
        markers: {
          Marker(
            markerId: MarkerId('currentlocation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: _currentLocation!,
          ),
          Marker(
            markerId: MarkerId('destinationlocation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            position: _destinationLocation,
          ),
          Marker(
            markerId: MarkerId('userlocation'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            position: _userLocation,
          ),
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  Future<void> initMapStyle() async {
    var roadColor = await DefaultAssetBundle.of(context).loadString('lib/feature/map/assets/map_style/road_color_gray.json');
    googleMapController?.setMapStyle(roadColor);
  }
}