import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ShowMapBtn extends StatelessWidget {
  const ShowMapBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // go to map page
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(translate.showMap),
            ),
          ),
        ),
      ],
    );
  }
}
