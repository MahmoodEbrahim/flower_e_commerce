import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_details_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/home_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {
      case AppRoutes.details:
        final product = settings.arguments as ProductsEntity;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(  product: product,),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => TestProductsScreen(),);

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}
