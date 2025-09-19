import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/address_detials_screen.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/saved_address.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/forget_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/login_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/reset_password_page.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/signup_page.dart';
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
import 'package:flower_e_commerce/features/payment_view/presentation/views/pages/PaymentViewPage.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/about_app_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/notifications_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/terms_and_condition_page.dart';
import 'package:flutter/material.dart';
import '../../features/profile/presentation/views/pages/change_password_screen.dart';
import '../../features/profile/presentation/views/pages/edit_profile_page.dart';

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
       // final args = settings.arguments as Map<String, dynamic>;
        // final categoryList = args[Constants.catList] as List<CategoriesEntity>;
        // final productsList = args[Constants.productList] as List<ProductsEntity>;
        return MaterialPageRoute(
          builder: (context) => CategoriesPage(),
        );
      case AppRoutes.editProfilePage:
      // final args = settings.arguments as List<OccasionsEntity>;
        return MaterialPageRoute(
            builder: (_) => EditProfilePage()
        );
      case AppRoutes.changePassword:
      // final args = settings.arguments as List<OccasionsEntity>;
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen()
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
      case AppRoutes.saveAddress:
        return MaterialPageRoute(builder: (context) => SavedAddress());

      case AppRoutes.addAddress:
        return MaterialPageRoute(
          builder: (context) => AddAddressDetialsScreen(),
        );

      case AppRoutes.about:
        return MaterialPageRoute(builder: (context) => AboutAppPage(),);

      case AppRoutes.termsAndCondition:
        return MaterialPageRoute(builder: (context) => TermsAndConditionPage(),);

      case AppRoutes.search:
        return MaterialPageRoute(builder: (context) => SearchPage(),);
      case AppRoutes.orderspage:
        return MaterialPageRoute(
          builder: (context) => OrderPage(),
        );
      case AppRoutes.notificationspage:
        return MaterialPageRoute(builder: (context) => NotificationsPage(),);
      case AppRoutes.checkoutscreen:
        final args = settings.arguments as CartEntity;
        return MaterialPageRoute(builder: (context) => CheckoutScreen(cart:args));
      case AppRoutes.paymentView:{
        final url = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => PaymentViewPage(url),);
      }
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
