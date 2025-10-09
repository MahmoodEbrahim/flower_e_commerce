import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';

class OrderPlacedSuccessfullyPage extends StatelessWidget {
  final String orderId;
  const OrderPlacedSuccessfullyPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.successOrderPlaced),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: SizedBox(
                child: Text(
                  translate.orderPlacedSuccessfullyTitle,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(
                    color: AppColors.blackColor[50]!,
                    fontSize: FontSize.s30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.trackingOrderPage,
                    arguments: orderId,
                  );
                },
                child: Text(translate.trackOrderButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
