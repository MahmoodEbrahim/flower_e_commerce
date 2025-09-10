import 'package:flower_e_commerce/config/theme/app_color.dart' show AppColors;
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ButtomSheetTitle extends StatelessWidget {
  const ButtomSheetTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t=AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
       t.sortBy ,
        textAlign: TextAlign.start,
        style: getBoldStyle(
          color: AppColors.pink,
          fontSize: FontSize.s20,
        ),
      ),
    );
  }
}
