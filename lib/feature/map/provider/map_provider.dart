import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MapProvider extends ChangeNotifier {
  LatLng? location;
  LatLng? destination;



  getMyData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double ?latitude=prefs.getDouble('startpointslat');
    double ?longitude=prefs.getDouble('startpointslon');
    double ?endlatitude=prefs.getDouble('endtpointslat');
    double ?endlongitude=prefs.getDouble('endtpointslon');
    location = LatLng(latitude!, longitude!);
    destination = LatLng(endlatitude!, endlongitude!);

    notifyListeners();
  }


  LocationData? currentLocation;
  final String apiKey = 'YOUR_API_KEY';
  GoogleMapController? controller;
  Set<Polyline> polylines = {};

  void initState() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location locationService = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await locationService.getLocation();

    if (currentLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'Lat: ${currentLocation!.latitude}, Lng: ${currentLocation!.longitude}',
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future<void> getRoute() async {
    if (currentLocation == null) return;

    String origin = '${currentLocation!.latitude},${currentLocation!.longitude}';
    LatLng destination1 = LatLng(30.588484799613905, 31.483259784097342); // First new destination coordinates
    LatLng destination2 = LatLng(30.046981770486305, 31.230994135789608); // Second new destination coordinates

    List<LatLng> destinations = [destination1, destination2];
    int retryCount = 3;

    for (LatLng destination in destinations) {
      for (int attempt = 0; attempt < retryCount; attempt++) {
        try {
          print(apiKey);
          final response = await http.post(
            Uri.parse(
              'https://routes.googleapis.com/directions/v2:computeRoutes?key=$apiKey',
            ),
            headers: {
              'Content-Type': 'application/json',
              'X-Goog-FieldMask': 'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
            },
            body: json.encode({
              'origin': {'location': {'latLng': {'latitude': currentLocation!.latitude, 'longitude': currentLocation!.longitude}}},
              'destination': {'location': {'latLng': {'latitude': destination.latitude, 'longitude': destination.longitude}}},
              'travelMode': 'DRIVE',
            }),
          ).timeout(const Duration(seconds: 30)); // Increase the timeout duration
          print(response.body);
          print(response.statusCode);
          if (response.statusCode == 200) {
            final data = json.decode(response.body);

            if (data['routes'] != null && data['routes'].isNotEmpty) {
              final encodedPolyline = data['routes'][0]['polyline']['encodedPolyline'];
              List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

              polylines.add(
                Polyline(
                  polylineId: PolylineId('route_${destination.latitude}_${destination.longitude}'), // Unique ID for each route
                  points: polylineCoordinates,
                  color: Colors.blue,
                  width: 5,
                ),
              );

              markers.add(
                Marker(
                  markerId: MarkerId('marker_${destination.latitude}_${destination.longitude}'), // Unique ID for each marker
                  position: destination,
                  infoWindow: InfoWindow(
                    title: 'Destination',
                    snippet: 'Lat: ${destination.latitude}, Lng: ${destination.longitude}',
                  ),
                ),
              );

              controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: destination,
                zoom: 12,
              )));
              notifyListeners();
              break; // Exit loop if successful
            }
          }
        } catch (e) {
          if (attempt < retryCount - 1) {
            await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
          }
        }
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      polyline.add(p);
    }

    return polyline;
  }
}
