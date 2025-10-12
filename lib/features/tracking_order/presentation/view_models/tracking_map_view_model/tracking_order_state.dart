import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingState extends Equatable {
  final RequestState requestState;
  final RemoteDataEntity? remoteData;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final LatLng? driverPosition;
  final String errorMessage;

  const TrackingState({
    this.requestState = RequestState.loading,
    this.remoteData,
    this.markers = const {},
    this.polylines = const {},
    this.driverPosition,
    this.errorMessage = '',
  });

  TrackingState copyWith({
    RequestState? requestState,
    RemoteDataEntity? remoteData,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    LatLng? driverPosition,
    String? errorMessage,
  }) {
    return TrackingState(
      requestState: requestState ?? this.requestState,
      remoteData: remoteData ?? this.remoteData,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      driverPosition: driverPosition ?? this.driverPosition,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [requestState, remoteData, markers, polylines, driverPosition, errorMessage];
}
