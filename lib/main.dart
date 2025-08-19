import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/routes_manager/routes_manager.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';import 'config/theme/app_theme.dart';
import 'features/auth/data/source/user_local_storage.dart';
import 'features/auth/domain/entity/login_entity.dart';
import 'features/auth/domain/entity/user_entity.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(LoginEntityAdapter());

  await UserLocalStorage.init();


  runApp(
    MyApp()
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = UserLocalStorage.isLoggedIn();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute:isLoggedIn? AppRoutes.signup:AppRoutes.login,
      onGenerateRoute: Routes.onGenerate,
      theme: AppTheme.lightTheme,
    );
  }
}