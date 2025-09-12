import 'package:device_preview/device_preview.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/routes_manager/routes_manager.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/app_theme.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/auth/api/source/user_local_storage.dart';
import 'features/auth/domain/entity/login_model.dart';
import 'features/auth/domain/entity/user_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(LoginModelAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  await UserLocalStorage.init();
  runApp(
      DevicePreview(builder: (context) =>
          BlocProvider(
            create: (context) => LanguageCubit()..getLanguage(),
            child: MyApp(),
          ))

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = UserLocalStorage.isLoggedIn();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final lang = context.read<LanguageCubit>().currentLanguage;
          return MaterialApp(

initialRoute: AppRoutes.login,
            //initialRoute:isLoggedIn? AppRoutes.home:AppRoutes.login,
            locale: Locale(lang),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.onGenerate,
            theme: AppTheme.lightTheme,
          );
        },
      ),

    );
  }
}
