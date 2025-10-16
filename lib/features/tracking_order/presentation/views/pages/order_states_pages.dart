import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/widgets/common_error.dart';
import 'package:flower_e_commerce/core/widgets/common_loading.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_events.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_states.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_view_model.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/waiting_confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool hasNavigated = false;

class OrderStatesPages extends StatelessWidget {
  final String orderId;
  OrderStatesPages({super.key, required this.orderId});

  final TrackingOrderViewModel _trackingOrderViewModel = getIt.get<TrackingOrderViewModel>();

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    bool hasNavigated = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(translate.trackingOrder),
      ),
      body: BlocProvider.value(
        value: _trackingOrderViewModel..add(GetDataFromRemoteEvent(orderId)),
        child: BlocListener<TrackingOrderViewModel, TrackingOrderState>(
          listener: (context, state) {
            if (state.remoteData != null && !hasNavigated) {
              hasNavigated = true;
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.orderPlacedSuccessfullyPage,
                arguments: orderId,
              );
            }
          },
          child: BlocBuilder<TrackingOrderViewModel, TrackingOrderState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CommonLoading();
              }

              if (state.errorMessage != null) {
                return CustumError(errorMessage: state.errorMessage);
              }

              if (state.remoteData == null) {
                return const WaitingForConfirmation();
              }

              return const CommonLoading(); 
            },
          ),
        ),
      ),
    );
  }
}
