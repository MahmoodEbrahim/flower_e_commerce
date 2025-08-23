import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';import 'config/theme/app_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MyApp()
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
