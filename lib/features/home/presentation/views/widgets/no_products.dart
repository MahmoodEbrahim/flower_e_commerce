import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 180.0,
        ),
        Icon(
          CupertinoIcons.info_circle_fill,
          size: 60,
          color: AppColors.pink,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          t.noProductsFound,
          style: getBoldStyle(color: AppColors.gray, fontSize: 20),
        )
      ],
    );
  }
}
