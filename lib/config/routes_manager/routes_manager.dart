import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasions_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/main_layout.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/best_seller_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/occasions_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/product_details_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/tabs/categories_tab.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        // final args = settings.arguments as List<ProductsEntity>;
        return MaterialPageRoute(builder: (context) => MainLayout(),);

      case AppRoutes.productDetails:
        return MaterialPageRoute(builder: (context) => ProductDetailsPage(),);


      case AppRoutes.categories:
        // final args = settings.arguments as List<CategoriesEntity>;
        return MaterialPageRoute(
          builder: (_) => CategoriesTab(

          )
        );

      case AppRoutes.bestSellers:
        // final args = settings.arguments as List<BestSellerEntity>;
        return MaterialPageRoute(
          builder: (_) => BestSellerPage(),
        );

      case AppRoutes.occasions:
        // final args = settings.arguments as List<OccasionsEntity>;
        return MaterialPageRoute(
          builder: (_) => OccasionsPage()
        );








      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}


