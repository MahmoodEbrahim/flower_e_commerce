import 'dart:async';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_bloc.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_event.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_order_state.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/deliver_order_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';

class TrackingMapScreen extends StatefulWidget {
  final String orderId;
  const TrackingMapScreen({super.key, required this.orderId});

  @override
  State<TrackingMapScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackingMapScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  String mapStyle = '';
  bool isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _checkPermission();
  }

  Future<void> _loadMapStyle() async {
    final style = await DefaultAssetBundle.of(
      context,
    ).loadString(JsonAssets.mapStyle);
    setState(() => mapStyle = style);
  }

  Future<void> _checkPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) setState(() => isPermissionGranted = true);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    if (!isPermissionGranted) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_off_outlined,
              color: AppColors.pink,
              size: 100,
              ),
              Text("permission required to track the order",
              style: getMediumStyle(
                fontSize: FontSize.s16, color: AppColors.black),
              ),
              Padding(padding: EdgeInsetsGeometry.all(15),
              child: ElevatedButton(onPressed: _checkPermission, child: Text(
                "Allow location access"
              )),)
            ],
          ),
        )
      );
    }

    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            getIt<TrackingBloc>()
              ..add(ListenToOrderStreamEvent("68f0aa587fee68a4c2ec7881")),
        child: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            final deliveryGender = state.remoteData?.driverEntity.gender;
            final deliveryName = state.remoteData?.driverEntity.firstName;

            if (state.requestState == RequestState.loading) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 230.0),
                    LoadingAnimationWidget.inkDrop(
                      color: AppColors.pink,
                      size: 50,
                    ),
                  ],
                ),
              );
            }
            if (state.requestState == RequestState.error) {
              return Center(child: Text(state.errorMessage));
            }

            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: GoogleMap(
                    style: mapStyle,
                    initialCameraPosition: CameraPosition(
                      target: state.driverPosition ?? const LatLng(30.0, 31.0),
                      zoom: 2,
                    ),
                    markers: state.markers,

                    polylines: state.polylines,
                    onMapCreated: (controller) {
                      _mapController.complete(controller);
                    },
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  color: AppColors.white,
                  child: DeliverOrderInfo(
                    deliveryGender: deliveryGender!,
                    deliveryName: deliveryName!,
                    phone: state.remoteData!.driverEntity.phone,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
