import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


import 'config/theme/app_theme.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
