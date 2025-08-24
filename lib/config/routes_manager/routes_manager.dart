import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/occasion_page.dart';
import 'package:flutter/material.dart';


abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {

     //OccasionPage
      case AppRoutes.occasion:
        return MaterialPageRoute(builder:
            (context)=>const OccasionPage());
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}
