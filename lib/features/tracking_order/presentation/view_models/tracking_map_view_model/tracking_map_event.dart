import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object?> get props => [];
}

class ListenToOrderStreamEvent extends TrackingEvent {
  final String orderId;
  const ListenToOrderStreamEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class UpdateDriverPositionEvent extends TrackingEvent {
  final LatLng newPosition;
  const UpdateDriverPositionEvent(this.newPosition);

  @override
  List<Object?> get props => [newPosition];
}
