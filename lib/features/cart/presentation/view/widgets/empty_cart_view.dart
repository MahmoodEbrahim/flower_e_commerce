import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const SizedBox(height: 20),
          Lottie.asset("assets/json/cart.json",
              width: 200.w,height: 150.h,fit: BoxFit.cover),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child:  Text(
             t.emptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.pink,
              ),
            ),
          ),
          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                child:  Text(
                 t.startShopping,
                  style: TextStyle(
                    fontSize: FontSize.s18,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
