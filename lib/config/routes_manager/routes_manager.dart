import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/forget_pass_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/home_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/login_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/signup_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (context) => const SignupPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => HomePage());

      case AppRoutes.forgetPass:
        return MaterialPageRoute(builder: (context) => ForgetPassPage());



      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}
