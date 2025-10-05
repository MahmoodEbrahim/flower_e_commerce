import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
final CameraPosition _cameraPosition=CameraPosition(target: LatLng(30.098702, 31.911280
),zoom: 14);
  final Completer<GoogleMapController>_controller=Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
      onMapCreated: (GoogleMapController controller){
       _controller.complete(controller);
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        moveToCairo();
      }),
      
    );
  }

  void moveToCairo()async {
    final GoogleMapController controller=await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(26.452896, 17.815801

      ),zoom: 18)
    ));
  }

}