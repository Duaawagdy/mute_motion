import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class MyMap extends StatefulWidget {
  const MyMap();
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController? googleMapController;
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  loc.Location _locationController = loc.Location();
  LatLng? _currentLocation;
  static const LatLng _destinationLocation = LatLng(30.541920853284697, 31.678156380256656);
  LatLng? _userLocation;

  final Mode _mode = Mode.overlay;
  final String googleApiKey = "AIzaSyCuTilAfnGfkZtIx0T3qf-eOmWZ_N2LpoY"; // Replace with your API key

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeMap();
  }

  Future<void> initializeMap() async {
    await getLocationUpdates();
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((loc.LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _userLocation = _currentLocation; // Update user location to current location
        });
      }
    });
  }

  Future<void> goToCurrentLocation() async {
    if (_currentLocation != null) {
      final GoogleMapController controller = await _mapController.future;
      CameraPosition newCameraPosition = CameraPosition(target: _currentLocation!, zoom: 16);
      await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  Future<void> goToUserLocation() async {
    if (_userLocation != null) {
      final GoogleMapController controller = await _mapController.future;
      CameraPosition newCameraPosition = CameraPosition(target: _userLocation!, zoom: 16);
      await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  Future<void> goToDestinationLocation() async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: _destinationLocation, zoom: 16);
    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future<void> handleSearch() async {
    setState(() {
      _isLoading = true;
    });

    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "us")],
      onError: (response) {
        print(response.errorMessage);
      },
    );

    await displayPrediction(p);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: googleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

      if (detail.status == "OK") {
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;
        LatLng searchedLocation = LatLng(lat, lng);

        setState(() {
          _userLocation = searchedLocation;
        });

        final GoogleMapController controller = await _mapController.future;
        CameraPosition newCameraPosition = CameraPosition(target: searchedLocation, zoom: 16);
        await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      } else {
        print("Error retrieving place details: ${detail.errorMessage}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              googleMapController = controller;
              initMapStyle();
            },
            initialCameraPosition: CameraPosition(target: _destinationLocation, zoom: 10),
            markers: {
              Marker(
                markerId: MarkerId('destinationlocation'),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                position: _destinationLocation,
              ),
              if (_userLocation != null)
                Marker(
                  markerId: MarkerId('userlocation'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: _userLocation!,
                ),
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: ElevatedButton(
              onPressed: handleSearch,
              child: Text("Search Location"),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: goToCurrentLocation,
            child: Icon(Icons.my_location),
            tooltip: 'Go to Current Location',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: goToUserLocation,
            child: Icon(Icons.person_pin_circle),
            tooltip: 'Go to User Location',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: goToDestinationLocation,
            child: Icon(Icons.location_pin),
            tooltip: 'Go to Destination',
          ),
        ],
      ),
    );
  }

  Future<void> initMapStyle() async {
    var roadColor = await DefaultAssetBundle.of(context).loadString('lib/feature/map/assets/map_style/road_color_gray.json');
    googleMapController?.setMapStyle(roadColor);
  }
}
