import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
       final t = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Icon(Icons.location_on_outlined)),
        Expanded(
          flex: 18,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis, 
            text: TextSpan(
              text: t.deliver_to,
              style: getRegularStyle(color: AppColors.black,fontSize: FontSize.s14),
              children: [
                TextSpan(
                  text:
                      t.bigAddress,
                  style: getBoldStyle(color: AppColors.black,fontSize: FontSize.s16),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down,)))
      ],
    );
  }
}
