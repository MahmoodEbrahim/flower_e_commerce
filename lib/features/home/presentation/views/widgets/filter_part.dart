import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_bootom_sheet.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterPart extends StatelessWidget {
  final ValueNotifier<String> catId;
  final BuildContext myContext;
  ValueNotifier<String?> selectedValue;
  FilterPart({
    super.key,
    required this.catId,
    required this.myContext,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: AppColors.white,
              context: myContext,
              builder: (context) => CustumBootomSheet(
                catId: catId,
                mycontext: myContext,
                selectedValue: selectedValue,
                t: t,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:  [
              Icon(Icons.filter_alt_rounded),
              SizedBox(width: 5),
              Text(t.filter),
            ],
          ),
        ),
      ),
    );
  }
}
