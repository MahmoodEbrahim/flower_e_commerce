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
import 'package:url_launcher/url_launcher.dart';
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
    on<CallUserEvent>(_callUser);
    on<WhatsAppUserEvent>(_openWhatsApp);
  }

  Future<void> _onListenToOrderStream(
      ListenToOrderStreamEvent event,
      Emitter<TrackingState> emit,
      ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    print("Listening to order stream for id: ${event.orderId}");

    final stream = _getDataFromRemoteUseCase.getOrderFromRemote(event.orderId);

    await emit.forEach<Result<RemoteDataEntity?>>(
      stream,
      onData: (result) {
        print("🔥 Bloc received result: $result");
        print("🔥 Result type: ${result.runtimeType}");
        if (result is SucessResult<RemoteDataEntity?>) {
          print("✅ Going to success");
          final data = result.sucessResult;
          if (data != null) {
            return _updateTracking(data);
          } else {
            return state.copyWith(requestState: RequestState.loading);
          }
        }
        else if (result is FailedResult) {
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
        icon: _driverMarker ??
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


    if (status == "outForDelivery") {
      _driverLatLng ??= _storeLatLng;
      _driverTarget = _userLatLng;
      _startSmoothMovement();
    } else if (status == "delivered") {
      _stopMovement();
      _driverLatLng = _userLatLng;
    } else {
      _stopMovement();
      _driverLatLng = _storeLatLng;
    }


    final markers = {
      Marker(
        markerId: const MarkerId(Constants.store),
        position: _storeLatLng!,
        infoWindow: const InfoWindow(title: Constants.store),
        icon: _storeAndUserMaker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
      Marker(
        markerId: const MarkerId(Constants.user),
        position: _userLatLng!,
        infoWindow: const InfoWindow(title: Constants.user),
        icon: _storeAndUserMaker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
      Marker(
        markerId: const MarkerId(Constants.driver),
        position: _driverLatLng!,
        infoWindow: const InfoWindow(title: Constants.driver),
        icon: _driverMarker ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
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

  void _startSmoothMovement() {
    _driverTimer?.cancel();

    const duration = Duration(milliseconds: 100);
    const stepFraction = 0.01;
    double progress = 0.0;

    _driverTimer = Timer.periodic(duration, (timer) {
      if (_driverLatLng == null || _driverTarget == null) return;

      progress += stepFraction;
      if (progress >= 1.0) {
        progress = 1.0;
        timer.cancel();
      }

      final newLat = _storeLatLng!.latitude +
          (_userLatLng!.latitude - _storeLatLng!.latitude) * progress;
      final newLng = _storeLatLng!.longitude +
          (_userLatLng!.longitude - _storeLatLng!.longitude) * progress;

      _driverLatLng = LatLng(newLat, newLng);

      add(UpdateDriverPositionEvent(_driverLatLng!));
    });
  }

  void _stopMovement() => _driverTimer?.cancel();

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


  Future<void> _callUser(
      CallUserEvent event, Emitter<TrackingState> emit) async {
    final Uri uri = Uri(scheme: 'tel', path: "0${event.phoneNumber}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      emit(state.copyWith(errorMessage: "call error"));
    }
  }

  Future<void> _openWhatsApp(
      WhatsAppUserEvent event, Emitter<TrackingState> emit) async {
    final phone = event.phoneNumber.startsWith("0")
        ? "2${event.phoneNumber.substring(1)}"
        : event.phoneNumber;

    final Uri uri = Uri.parse(
      "https://wa.me/$phone${event.message != null ? "?text=${Uri.encodeComponent(event.message!)}" : ""}",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      emit(state.copyWith(errorMessage: "whatsApp error"));
    }
  }
}
