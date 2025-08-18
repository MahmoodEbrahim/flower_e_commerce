
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/forget_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/reset_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/signup_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/verfiy_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {
      // case AppRoutes.signup:
      //   return MaterialPageRoute(builder: (context) => const SignpPag());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder:
            (context)=>const ForgetPasswordPage());
      case AppRoutes.verfiyPassword:
        return MaterialPageRoute(builder:
            (context)=>
      VerfiyPasswordPage());
        //ResetPasswordPage
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder:
            (context)=> ResetPasswordPage(),
            );
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}
