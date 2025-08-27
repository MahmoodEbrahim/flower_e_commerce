import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/best_seller_page.dart';
import 'package:flutter/material.dart';


abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {
      case AppRoutes.bestseller:
        return MaterialPageRoute(builder:
            (context)=>BestSeller());

     
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(backgroundColor: Colors.white,
              body: Center(child: Text("No Route Page"))),
        );
    }
  }
}