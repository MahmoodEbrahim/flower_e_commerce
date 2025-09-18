import 'package:device_preview/device_preview.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/routes_manager/routes_manager.dart';
import 'features/auth/api/source/user_local_storage_imp.dart';
import 'features/auth/data/source/user_local_storage.dart';
import 'features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import 'features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';
import 'features/auth/presentation/view_model/user_session_view_model/user_session_state.dart';
import 'features/auth/presentation/views/pages/login_page.dart';
import 'features/home/presentation/views/pages/main_layout.dart';
import 'config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await Hive.initFlutter();
  await getIt<UserLocalStorage>().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit()..getLanguage()),
        BlocProvider(
          create: (context) =>
          getIt<UserSessionBloc>()..add(LoadUserFromCache()),
        ),
      ],
      child: DevicePreview(
        enabled: true, // false في الإنتاج
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final lang = context.read<LanguageCubit>().currentLanguage;

          return BlocBuilder<UserSessionBloc, UserSessionState>(
            builder: (context, sessionState) {
              Widget home;

              switch (sessionState.status) {
                case UserSessionStatus.loading:
                  home = const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                  break;
                case UserSessionStatus.authenticated:
                  case UserSessionStatus.authenticatedGuest:
                  home = const MainLayout(); // الصفحة الرئيسية
                  break;
                case UserSessionStatus.unauthenticated:
                  home = LoginPage(); // صفحة تسجيل الدخول
                  break;
                default:
                  home = const SizedBox();
              }

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: Locale(lang),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateRoute:  Routes.onGenerate,
                theme: AppTheme.lightTheme,
                home: home,
              );
            },
          );
        },
      ),
    );
  }
}
