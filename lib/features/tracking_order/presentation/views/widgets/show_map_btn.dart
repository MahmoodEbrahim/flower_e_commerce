import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class ShowMapBtn extends StatelessWidget {
  final String orderId;
  const ShowMapBtn({required this.orderId,super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
             Navigator.pushNamed(context, AppRoutes.trackingMap,
             arguments: orderId);
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
