import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/driver_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_events.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_view_model.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/cache_image.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/show_map_btn.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/text_section.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/time_line_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SuccessTrackingOrder extends StatelessWidget {
  const SuccessTrackingOrder({
    super.key,
  
    required this.driverData,
    required TrackingOrderViewModel trackingOrderViewModel,
    required this.count,
    required this.orderId,
  }) : _trackingOrderViewModel = trackingOrderViewModel;


  final DriverEntity driverData;
  final TrackingOrderViewModel _trackingOrderViewModel;
  final int count;
  final String orderId;

  @override
  Widget build(BuildContext context) {
      final translate = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSection(
            txt1: translate.estimatedArrival,
            txt2:
                "03 Sep 2024, 11:00 AM", //  will be replaced when data came from firebase
    
            style1: getBoldStyle(
              color: AppColors.gray,
              fontSize: FontSize.s14,
            ).copyWith(letterSpacing: 1),
            style2: getBoldStyle(
              color: AppColors.black,
              fontSize: FontSize.s18,
            ).copyWith(letterSpacing: 1),
          ),
    
          Divider(),
    
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //image
                CacheImage(),
    
                //col
                Flexible(
                  child: TextSection(
                    txt1: driverData.firstName,
                    txt2: translate.isYourDelivery,
    
                    style1: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s18,
                    ),
                    style2: getBoldStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s12,
                    ).copyWith(letterSpacing: 1),
                  ),
                ),
    
                IconButton(
                  onPressed: () {
                    if (driverData.phone.isNotEmpty) {
                      _trackingOrderViewModel.add(
                        CallUserEvent(driverData.phone),
                      );
                    }
                  },
                  icon: Icon(Icons.phone, color: AppColors.pink),
                ),
    
                IconButton(
                  onPressed: () {
                    if (driverData.phone.isNotEmpty) {
                      _trackingOrderViewModel.add(
                        WhatsAppUserEvent(driverData.phone),
                      );
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColors.pink,
                  ),
                ),
              ],
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(child: Image.asset(AssetsManager.carImage)),
          ),
          SizedBox(height: 12),
    
          Expanded(
            child: TimeLineList(count: count, orderId: orderId),
          ),
    
          ShowMapBtn(),
        ],
      ),
    );
  }
}

