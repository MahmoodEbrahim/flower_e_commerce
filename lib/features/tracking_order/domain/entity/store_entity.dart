import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreEntity {
    String name;
    String image;
    String address;
    String phoneNumber;
    LatLng latLong;

    StoreEntity({
        required this.name,
        required this.image,
        required this.address,
        required this.phoneNumber,
        required this.latLong,
    });

   
}
