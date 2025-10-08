import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/enum/order_state_enum.dart';
import 'package:flower_e_commerce/core/helpers/order_data_helper.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/widgets/common_loading.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_events.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_states.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_view_model.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/success_tracking_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingOrderPage extends StatelessWidget {
  final String orderId;
  TrackingOrderPage({super.key, required this.orderId});
  final OrderDateHelper orderDateHelper = getIt.get<OrderDateHelper>();

  // fn take state then decide who will be colorfull

  int decideColor(String state) {
    if (state == OrderStatus.received.name) {
      return 1;
    }
    if (state == OrderStatus.preparing.name) {
      return 2;
    }

    if (state == OrderStatus.outForDelivery.name) {
      return 3;
    }
    if (state == OrderStatus.delivered.name) {
      return 4;
    } else {
      return 1;
    }
  }

  final TrackingOrderViewModel _trackingOrderViewModel = getIt
      .get<TrackingOrderViewModel>();

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: _trackingOrderViewModel..add(GetDataFromRemoteEvent(orderId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),

          title: Text(translate.trackingOrder),
        ),

        body: BlocConsumer<TrackingOrderViewModel, TrackingOrderState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              state.copyWith(errorMessage: null);
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return CommonLoading();
            }

            if (state.remoteData != null) {
              final driverData = state.remoteData!.driverEntity;
              final orderState = state.remoteData!.orderDeliveryStatus;

              int count = decideColor(orderState!);

              return SuccessTrackingOrder(driverData: driverData, trackingOrderViewModel: _trackingOrderViewModel, count: count, orderId: orderId);
            } else {
              return Center(child: Text(translate.unExpextedError));
            }
          },
        ),
      ),
    );
  }
}

