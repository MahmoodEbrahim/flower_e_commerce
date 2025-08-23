import 'package:device_preview/device_preview.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/routes_manager/routes_manager.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';import 'config/theme/app_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
   DevicePreview(builder: (context)=> MyApp())
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute:Routes.onGenerate,
      initialRoute:AppRoutes.home ,
      theme: AppTheme.lightTheme,
    );
  }
}
