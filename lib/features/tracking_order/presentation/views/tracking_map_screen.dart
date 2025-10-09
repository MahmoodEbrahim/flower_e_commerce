import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_bloc.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_event.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_order_state.dart';
import 'package:permission_handler/permission_handler.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  GoogleMapController? _mapController;
  String style = "";
  bool isPermissionGranted = false;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Timer? _driverMoveTimer;

  LatLng? _driverLatLng;
  LatLng? _driverTarget;
  String? _lastStatus;

  LatLng? _userLatLng;
  LatLng? _storeLatLng;

  @override
  void dispose() {
    _driverMoveTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadMapStyle();
    _checkPermissionRequest();
    super.initState();
  }

  /// 🔹 دالة تحسب نقطة بين نقطتين بنسبة معينة
  LatLng _interpolate(LatLng start, LatLng end, double fraction) {
    final lat = start.latitude + (end.latitude - start.latitude) * fraction;
    final lng = start.longitude + (end.longitude - start.longitude) * fraction;
    return LatLng(lat, lng);
  }

  /// 🔹 تحديث أو إنشاء marker السائق
  void _addOrUpdateDriverMarker(LatLng pos) {
    _driverLatLng = pos;
    _markers.removeWhere((m) => m.markerId.value == 'driver');
    _markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: pos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Driver'),
      ),
    );
  }

  void _stopDriverMovement() {
    _driverMoveTimer?.cancel();
    _driverMoveTimer = null;
  }

  /// 🔹 حركة السائق التدريجية نحو الهدف
  void _startDriverMovement() {
    if (_driverTarget == null) return;
    if (_driverMoveTimer != null && _driverMoveTimer!.isActive) return;

    _driverLatLng ??= _storeLatLng;

    const double stepFraction = 0.15;
    _driverMoveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = context.read<TrackingBloc>().state;
      if (currentState is TrackingLoaded &&
          currentState.remoteData.orderDeliveryStatus ==
              "Delivered to the user") {
        _stopDriverMovement();
        _addOrUpdateDriverMarker(_userLatLng!);
        _mapController?.animateCamera(CameraUpdate.newLatLng(_userLatLng!));
        setState(() {});
        return;
      }

      final target = _driverTarget!;
      final current = _driverLatLng!;
      final newLat =
          current.latitude +
          (target.latitude - current.latitude) * stepFraction;
      final newLng =
          current.longitude +
          (target.longitude - current.longitude) * stepFraction;
      final nextPos = LatLng(newLat, newLng);

      _addOrUpdateDriverMarker(nextPos);
      _mapController?.animateCamera(CameraUpdate.newLatLng(nextPos));
      setState(() {});

      const latThreshold = 0.00003;
      const lngThreshold = 0.00003;
      if ((target.latitude - nextPos.latitude).abs() < latThreshold &&
          (target.longitude - nextPos.longitude).abs() < lngThreshold) {
        timer.cancel();
        _driverMoveTimer = null;
      }
    });
  }

  /// 🔹 التعامل مع بيانات الـ Bloc (التحديث عند كل state جديدة)
  void _handleRemoteData(RemoteDataEntity data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // نأخذ الإحداثيات من الـ data
      _userLatLng = LatLng(
        29.958303771150497, 32.55076403285353
      );
      _storeLatLng = LatLng(
       29.96021389865674, 32.559754393937126
      );

      // _userLatLng = LatLng(
      //   data.orderEntity.shippingAddress.lat,
      //   data.orderEntity.shippingAddress.long ,
      // );
      // _storeLatLng = LatLng(data.orderEntity.store.latLong.latitude,
      // data.orderEntity.store.latLong.longitude);

      // نرسم المسار بين المتجر والمستخدم
      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.pink,
          width: 5,
          points: [_storeLatLng!, _userLatLng!],
        ),
      };

      // markers الأساسية
      _markers.removeWhere(
        (m) => m.markerId.value == 'store' || m.markerId.value == 'user',
      );
      _markers.addAll({
        Marker(
          markerId: const MarkerId('store'),
          position: _storeLatLng!,
          infoWindow: const InfoWindow(title: 'Store'),
        ),
        Marker(
          markerId: const MarkerId('user'),
          position: _userLatLng!,
          infoWindow: const InfoWindow(title: 'User'),
        ),
      });

      _driverLatLng ??= _storeLatLng;
      _addOrUpdateDriverMarker(_driverLatLng!);

      final status = data.orderDeliveryStatus;

      if (status != _lastStatus) {
        _lastStatus = status;

        double fraction;
        switch (status) {
          case "waiting":
            fraction = 0.0;
            break;
          case "Arrived at Pickup point":
            fraction = 0.25;
            break;
          case "Start deliver":
            fraction = 0.5;
            break;
          case "Arrived to the user":
            fraction = 0.75;
            break;
          case "Delivered to the user":
            fraction = 1.0;
            break;
          default:
            fraction = 0.0;
        }

        _driverTarget = _interpolate(_storeLatLng!, _userLatLng!, fraction);

        if (fraction == 1.0) {
          _stopDriverMovement();
          _addOrUpdateDriverMarker(_userLatLng!);
          _mapController?.animateCamera(CameraUpdate.newLatLng(_userLatLng!));
        } else {
          _startDriverMovement();
        }

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) =>
            getIt<TrackingBloc>()
              ..add(ListenToOrderStreamEvent("68e7893e7fee68a4c2e9f6a0")),
        child: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            if (state is TrackingLoading || state is TrackingInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrackingError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is TrackingLoaded) {
              _handleRemoteData(state.remoteData);

              final initialPos = _userLatLng ?? const LatLng(29.99, 32.51);

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialPos,
                  zoom: 13,
                ),
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (controller) => _mapController = controller,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _loadMapStyle() async {
    String mapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_style.json");
    setState(() {
      style = mapStyle;
    });
  }

  _checkPermissionRequest() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        isPermissionGranted = true;
      });
    } else {
      print("❌ Permission denied by user");
    }
  }
}
