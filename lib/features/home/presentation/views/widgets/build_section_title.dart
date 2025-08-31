 import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

Widget buildSectionTitle(String title, VoidCallback onSeeAll,BuildContext context) {
  final t=AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onSeeAll,
            child:  Text(t.seeAll,
                style: TextStyle(color: Colors.pink, fontSize: 15)),
          ),
        ],
      ),
    );
  }
