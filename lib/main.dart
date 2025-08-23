import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/routes_manager/routes_manager.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/api/source/user_local_storage.dart';
import 'features/auth/domain/entity/login_model.dart';
import 'features/auth/domain/entity/user_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(LoginModelAdapter());
  await UserLocalStorage.init();
  runApp(
    MyApp()
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

final bool isLoggedIn = UserLocalStorage.isLoggedIn();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(

        initialRoute:isLoggedIn? AppRoutes.home:AppRoutes.login,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerate,
        theme: AppTheme.lightTheme,
      ),

    );
  }
}