import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/forget_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/login_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/reset_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/signup_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/verfiy_password.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/pages/cart_page.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/main_layout.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/all_products.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/best_seller_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/categories_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/occasion_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_by_category.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => MainLayout());
   

    case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (context) => CartPage(),
        );
      case AppRoutes.bestSellers:
        final args = settings.arguments as Map<String, dynamic>;
        final bestSeller = args[Constants.bestSeller] as List<BestSellerEntity>;
        return MaterialPageRoute(
          builder: (_) => BestSellerPage(bestSelller: bestSeller),
        );

      case AppRoutes.occasions:
        final args = settings.arguments as Map<String, dynamic>;
        final occasions = args[Constants.occasions] as List<OccasionsEntity>;
        return MaterialPageRoute(
          builder: (_) => OccasionPage(occasions: occasions),
        );

      case AppRoutes.catergories:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryList = args[Constants.catList] as List<CategoriesEntity>;
        final productsList = args[Constants.productList] as List<ProductsEntity>;
        return MaterialPageRoute(
          builder: (context) => CategoriesPage(
            categoryList: categoryList,
            produdctsList: productsList,
          ),
        );

      case AppRoutes.allProducts:
        final args = settings.arguments as Map<String, dynamic>;
        final allProducts = args[Constants.allProducts] as List<ProductsEntity>;
        return MaterialPageRoute(
          builder: (context) => AllProductsPage(allProducts: allProducts),
        );

      case AppRoutes.details:
        final product = settings.arguments as ProductsEntity;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(product: product),
        );

      case AppRoutes.productByCat:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryId = args[Constants.catId] as String;
        final categoryName = args[Constants.catName] as String;
        return MaterialPageRoute(
          builder: (context) =>
              ProductsCategory(catId: categoryId, catName: categoryName),
        );

      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (context) => SignupPage());

      case AppRoutes.forgetPass:
        return MaterialPageRoute(builder: (context) => ForgetPasswordPage());

      case AppRoutes.verfiyPassword:
        return MaterialPageRoute(builder: (context) => VerifyPasswordPage());

      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (context) => ResetPasswordPage());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
