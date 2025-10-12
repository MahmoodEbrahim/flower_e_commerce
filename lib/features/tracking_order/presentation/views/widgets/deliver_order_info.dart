import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DeliverOrderInfo extends StatelessWidget {
  String deliveryGender;
  String deliveryName;
  DeliverOrderInfo({
    required this.deliveryGender,
    required this.deliveryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            t.estimatedArrival,
            style: getMediumStyle(
              color: AppColors.gray,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

          child: Text(
            DateFormat('EEE, dd MMM yyyy, hh:mm a').format(DateTime.now()),
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        Divider(color: AppColors.whiteColor[70]),

        Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            children: [
              (deliveryGender == Constants.male)
                  ? SvgPicture.asset(
                      ImageAssets.deliveryBoy,
                      height: 50,
                      width: 50,
                    )
                  : Image.asset(
                      width: 50,
                      height: 50,
                      ImageAssets.deliveryGirl,
                    ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryName,
                    style: getMediumStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    t.deliveryHero,
                    style: getMediumStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(t.orderDetails),
            ),
          ),
        ),
      ],
    );
  }
}
