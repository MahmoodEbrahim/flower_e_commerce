import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/enum/order_state_enum.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/cache_image.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/text_section.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/time_line_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    int count = decideColor("Received"); // example until data came from bloc
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),

        title: Text(t.trackingOrder),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSection(
              txt1: t.estimatedArrival,
              txt2:
                  "03 Sep 2024, 11:00 AM", //  fake data will be removed when data came

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
                  TextSection(
                    txt1: "Muhamed", // fake data will be removed when data came
                    txt2:
                        "is your delivery hero for today", // fake data will be removed when data came

                    style1: getBoldStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s18,
                    ),
                    style2: getBoldStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s14,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      // will be added with bloc
                      
                    },
                    icon: Icon(Icons.phone, color: AppColors.pink),
                  ),

                  IconButton(
                    onPressed: () {
                      // will be added with bloc
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

            Expanded(child: TimeLineList(count: count)),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // go to map page
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(t.showMap),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
