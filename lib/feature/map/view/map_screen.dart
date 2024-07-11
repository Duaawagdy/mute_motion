import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion/feature/map/view/widgets/containerdisplay.dart';

import 'package:provider/provider.dart';

import '../provider/map_provider.dart';


import 'package:mute_motion/core/once_future_builder.dart';


class RouteScreen extends StatelessWidget {
  const RouteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, provider, child) {
      return OnceFutureBuilder(
        future: ()async{
          provider.initState();
        },
        builder:(context,snapshot) => Scaffold(

          body: Stack(
            children: <Widget>[
              provider.currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                onMapCreated: (controller) {
                  provider.controller = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(provider.currentLocation!.latitude!,
                      provider.currentLocation!.longitude!),
                  zoom: 14.0,
                ),
                polylines: provider.polylines,
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(provider.currentLocation!.latitude!,
                        provider.currentLocation!.longitude!),
                    infoWindow: const InfoWindow(
                      title: 'Current Location',
                    ),
                  ),
                },
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: maindisplay(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: provider.getRoute,
            child: const Icon(Icons.directions),
          ),
        ),
      );
    });
  }
}
