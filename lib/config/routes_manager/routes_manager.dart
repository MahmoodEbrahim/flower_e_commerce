import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/address_detials_screen.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/saved_address.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/login_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/signup_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/forget_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/reset_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/verfiy_password.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/pages/cart_page.dart';
import 'package:flower_e_commerce/features/checkout/presentation/views/checkout-screen.dart';
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
import 'package:flower_e_commerce/features/home/presentation/views/pages/search_page.dart';
import 'package:flower_e_commerce/features/orders/presentation/view/pages/orderpage.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/about_app_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/notifications_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/terms_and_condition_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/change_password_screen.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/edit_profile_page.dart';

abstract class Routes{
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case AppRoutes.saveAddress:
        return MaterialPageRoute(builder: (_) => SavedAddress());

      case AppRoutes.addAddress:
        return MaterialPageRoute(builder: (_) => AddAddressDetialsScreen());

      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartPage());

      case AppRoutes.checkoutscreen:
        final cart = settings.arguments as CartEntity;
        return MaterialPageRoute(builder: (_) => CheckoutScreen(cart: cart));

      case AppRoutes.orderspage:
        return MaterialPageRoute(builder: (_) => OrderPage());

      case AppRoutes.bestSellers:
        final args = settings.arguments as Map<String, dynamic>;
        final bestSeller = args[Constants.bestSeller] as List<BestSellerEntity>;
        return MaterialPageRoute(
            builder: (_) => BestSellerPage(bestSelller: bestSeller));

      case AppRoutes.occasions:
        final args = settings.arguments as Map<String, dynamic>;
        final occasions = args[Constants.occasions] as List<OccasionsEntity>;
        return MaterialPageRoute(
            builder: (_) => OccasionPage(occasions: occasions));

      case AppRoutes.catergories:
        return MaterialPageRoute(builder: (_) => CategoriesPage());

      case AppRoutes.allProducts:
        final args = settings.arguments as Map<String, dynamic>;
        final allProducts = args[Constants.allProducts] as List<ProductsEntity>;
        return MaterialPageRoute(
            builder: (_) => AllProductsPage(allProducts: allProducts));

      case AppRoutes.details:
        final product = settings.arguments as ProductsEntity;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product));

      case AppRoutes.productByCat:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryId = args[Constants.catId] as String;
        final categoryName = args[Constants.catName] as String;
        return MaterialPageRoute(
            builder: (_) =>
                ProductsCategory(catId: categoryId, catName: categoryName));

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupPage());

      case AppRoutes.forgetPass:
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage());

      case AppRoutes.verfiyPassword:
        return MaterialPageRoute(builder: (_) => VerifyPasswordPage());

      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());

      case AppRoutes.editProfilePage:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());

      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => AboutAppPage());

      case AppRoutes.termsAndCondition:
        return MaterialPageRoute(builder: (_) => TermsAndConditionPage());

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => SearchPage());

      case AppRoutes.notificationspage:
        return MaterialPageRoute(builder: (_) => NotificationsPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
