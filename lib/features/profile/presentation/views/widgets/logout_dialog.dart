import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import '../../../../../config/routes_manager/app_routes.dart';
import '../../../../../core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.logout,
            ),
            const SizedBox(height: 10),
            Text(
              t.confirmLogout,
              style: getRegularStyle(
                  color: AppColors.black, fontSize: FontSize.s16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel button
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: Text(
                    t.cancel,
                    style: getMediumStyle(color: AppColors.black),
                  ),
                ),

                // Logout button
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final userStorage = getIt<UserLocalStorage>();
                    await userStorage.clearToken();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: Text(
                    t.logout,
                    style: getMediumStyle(color: AppColors.white),
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
