import 'dart:async';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/usecase/get_data_from_remote.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'tracking_map_event.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final GetDataFromRemoteUseCase _getDataFromRemoteUseCase;

  Timer? _driverTimer;
  LatLng? _driverLatLng, _driverTarget, _storeLatLng, _userLatLng;
  BitmapDescriptor? _driverMarker;
  BitmapDescriptor? _storeAndUserMaker;

  TrackingBloc(this._getDataFromRemoteUseCase) : super(const TrackingState()) {
    on<ListenToOrderStreamEvent>(_onListenToOrderStream);
    on<UpdateDriverPositionEvent>(_onUpdateDriverPosition);
    _loadCustomMarker();
  }

  Future<void> _onListenToOrderStream(
    ListenToOrderStreamEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final stream = _getDataFromRemoteUseCase.getOrderFromRemote(event.orderId);

    await emit.forEach<Result<RemoteDataEntity>>(
      stream,
      onData: (result) {
        if (result is SucessResult<RemoteDataEntity>) {
          final data = result.sucessResult;
          return _updateTracking(data);
        } else if (result is FailedResult) {
          return state.copyWith(
            requestState: RequestState.error,
            errorMessage: Constants.errorTracking,
          );
        } else {
          return state.copyWith(requestState: RequestState.loading);
        }
      },
    );
  }

  void _onUpdateDriverPosition(
    UpdateDriverPositionEvent event,
    Emitter<TrackingState> emit,
  ) {
    final updatedMarkers = Set<Marker>.from(state.markers ?? {});
    updatedMarkers.removeWhere((m) => m.markerId.value == Constants.driver);
    updatedMarkers.add(
      Marker(
        markerId: const MarkerId(Constants.driver),
        position: event.newPosition,
        icon:
            _driverMarker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: const InfoWindow(title: Constants.driver),
      ),
    );

    emit(
      state.copyWith(
        driverPosition: event.newPosition,
        markers: updatedMarkers,
      ),
    );
  }

  TrackingState _updateTracking(RemoteDataEntity data) {
    _userLatLng = LatLng(
      double.parse(data.orderEntity.shippingAddress.lat),
      double.parse(data.orderEntity.shippingAddress.long),
    );

    final storeCoords = data.orderEntity.store.latLong.split(',');
    _storeLatLng = LatLng(
      double.parse(storeCoords.first),
      double.parse(storeCoords.last),
    );

    final status = data.orderDeliveryStatus;
    double fraction = _getFractionFromStatus(status!);

    _driverTarget = _interpolate(_storeLatLng!, _userLatLng!, fraction);
    _driverLatLng ??= _storeLatLng;

    if (fraction == 1.0) {
      _stopMovement();
      _driverLatLng = _userLatLng!;
    } else {
      _startMovement();
    }

    final markers = {
      Marker(
        markerId: const MarkerId(Constants.store),
        position: _storeLatLng!,
        infoWindow: const InfoWindow(title: Constants.store),
        icon:
            _storeAndUserMaker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
      Marker(
        markerId: const MarkerId(Constants.user),
        position: _userLatLng!,
        icon:
            _storeAndUserMaker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),

        infoWindow: const InfoWindow(title: Constants.user),
      ),
      Marker(
        markerId: const MarkerId(Constants.driver),
        position: _driverLatLng!,
        icon:
            _driverMarker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        infoWindow: const InfoWindow(title: Constants.driver),
      ),
    };

    final polyline = {
      Polyline(
        polylineId: const PolylineId(Constants.route),
        color: AppColors.pink,
        width: 3,
        points: [_storeLatLng!, _userLatLng!],
      ),
    };

    return state.copyWith(
      requestState: RequestState.success,
      remoteData: data,
      markers: markers,
      polylines: polyline,
      driverPosition: _driverLatLng,
    );
  }

  void _startMovement() {
    _driverTimer?.cancel();

    _driverTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (_driverLatLng == null || _driverTarget == null) return;

      final distance = _calculateDistance(_driverLatLng!, _driverTarget!);
      if (distance < 0.0005) {
        _driverLatLng = _driverTarget;
        _driverTimer?.cancel();
      } else {
        final newLat =
            _driverLatLng!.latitude +
            (_driverTarget!.latitude - _driverLatLng!.latitude) * 0.2;
        final newLng =
            _driverLatLng!.longitude +
            (_driverTarget!.longitude - _driverLatLng!.longitude) * 0.2;
        _driverLatLng = LatLng(newLat, newLng);
      }

      add(UpdateDriverPositionEvent(_driverLatLng!));
    });
  }

  void _stopMovement() => _driverTimer?.cancel();

  double _calculateDistance(LatLng a, LatLng b) =>
      ((a.latitude - b.latitude) * (a.latitude - b.latitude) +
              (a.longitude - b.longitude) * (a.longitude - b.longitude))
          .abs();

  LatLng _interpolate(LatLng start, LatLng end, double fraction) => LatLng(
    start.latitude + (end.latitude - start.latitude) * fraction,
    start.longitude + (end.longitude - start.longitude) * fraction,
  );

  //will change ,after change --> delete hard code
  double _getFractionFromStatus(String status) {
    switch (status) {
      case "waiting":
        return 0.0;
      case "Arrived at Pickup point":
        return 0.25;
      case "Start deliver":
        return 0.5;
      case "Arrived to the user":
        return 0.75;
      case "Delivered to the user":
        return 1.0;
      default:
        return 0.0;
    }
  }

  Future<BitmapDescriptor> customMarker(String marker) async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(40, 40)),
      marker,
    );
  }

  Future<void> _loadCustomMarker() async {
    _driverMarker = await customMarker(ImageAssets.deliveryMotorcycle);
    _storeAndUserMaker = await customMarker(ImageAssets.placeMarker);
  }
}
