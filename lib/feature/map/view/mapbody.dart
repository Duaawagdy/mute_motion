import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController? googleMapController;
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  Location _locationController = Location();
  LatLng? _currentLocation=null;
  Map<PolylineId, Polyline> polylines = {};
  static const LatLng _destinationLocation = LatLng(30.541920853284697, 31.678156380256656);
  static const LatLng _userLocation = LatLng(30.538064272855628, 31.662419559020925);

  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    getLocationUpdated().then((_) {
      getPolylinePoints().then((coordinates) {
        generatePolyline(coordinates);
      });
    });
  }

  @override
  void dispose() {
   // _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? Center(child: Text('loading...'))
          : GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
          googleMapController = controller;
          initMapStyle();
        },
        initialCameraPosition: CameraPosition(target: _destinationLocation, zoom: 15),
        markers: {
          Marker(
              markerId: MarkerId('currentLocation'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              position: _currentLocation!),
          Marker(
              markerId: MarkerId('destinationLocation'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              position: _destinationLocation),
          Marker(
              markerId: MarkerId('userLocation'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              position: _userLocation)
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  Future<void> initMapStyle() async {
    var roadColor = await DefaultAssetBundle.of(context).loadString('lib/feature/map/assets/map_style/road_color_gray.json');
    googleMapController?.setMapStyle(roadColor);
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 17);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdated() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription = _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            cameraToPosition(_currentLocation!);
          });
        }
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC2Zz-eWGawv378cWw5Olhayx9SAX72Jko",  // Replace with your actual API key
        PointLatLng(_userLocation.latitude, _userLocation.longitude),
        PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print('No polyline points found.');
      }
    } catch (e) {
      print('Error fetching polyline points: $e');
    }

    return polylineCoordinates;
  }

  Future<void> generatePolyline(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
