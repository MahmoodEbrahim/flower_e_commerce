import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/routes_manager/app_routes.dart';
import '../../../../auth/api/source/user_local_storage.dart';
import '../../../../../core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
final token=UserLocalStorage.getToken()??"";
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
              t.confirmLogout, //
                style: getRegularStyle(color: AppColors.black,fontSize: FontSize.s16)
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
                    style: getMediumStyle(color: AppColors.black)
                  ),
                ),

                // Logout button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<SettingCubit>(context).logOut(token);
                    UserLocalStorage.clearUser();
                    UserLocalStorage.clearToken();

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
                  child: Text(t.logout,
                      style: getMediumStyle(color: AppColors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
