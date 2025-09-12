// import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
// import 'package:flower_e_commerce/config/theme/app_color.dart';
// import 'package:flower_e_commerce/config/theme/font_manger.dart';
// import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
// import 'package:flower_e_commerce/core/di/di.dart';
// import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
// import 'package:flower_e_commerce/core/widgets/common_error.dart';
// import 'package:flower_e_commerce/core/widgets/common_loading.dart';
// import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view/widgets/card_section.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view/widgets/delivery_location.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view/widgets/empty_cart_view.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view/widgets/total_calculation_part.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   final CartViewModel cartViewModel = getIt.get<CartViewModel>();
//
//   final ValueNotifier<int> price = ValueNotifier<int>(0);
//
//   final ValueNotifier<bool> isEmptyCart = ValueNotifier<bool>(true);
//   @override
//   void initState() {
//     cartViewModel.add(GetCartItemsEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context)!;
//     final user = UserLocalStorage.getUser();
//
//     if (user == null || user.user == null) {
//       print("User not found");
//     } else {
//       print("User is already exist");
//       print("##########################${user.user!.firstName}");
//     }
//
//     final addresses = user?.user?.addresses ?? [];
//     if (addresses.isNotEmpty) {
//       print("User addresses exist: $addresses");
//     } else {
//       print("No addresses found");
//     }
//
//     final city = addresses.isNotEmpty ? addresses[0].city : "No City";
//     final location = addresses.isNotEmpty ? addresses[0].street : "No Street";
//     print("Location: $location");
//     print("Length: ${addresses.length}");
//     return BlocProvider.value(
//       value: cartViewModel,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           title: Text(t.cart),
//           titleSpacing: 0,
//           scrolledUnderElevation: 0,
//           leading: IconButton(
//             constraints: BoxConstraints(),
//             padding: EdgeInsets.zero,
//             onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
//             icon: Icon(Icons.arrow_back_ios),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DeliveryLocation(),
//               SizedBox(
//                 height: 430,
//                 child: BlocConsumer<CartViewModel, CartStates>(
//                   listener: (context, state) {
//                     if (state.cartResonse != null) {
//                       if (state.cartResonse!.cart!.cartItems!.isEmpty) {
//                         isEmptyCart.value = true;
//
//                       } else {
//                         isEmptyCart.value = false;
//
//                       }
//                       price.value = state.cartResonse!.cart!.totalPrice!;
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state.isLoading) {
//
//                       return CommonLoading();
//                     }
//                     if (state.cartResonse != null) {
//                       if (state.cartResonse!.cart!.cartItems!.isEmpty) {
//                         isEmptyCart.value = true;
//                         return EmptyCartView();
//                       } else {
//                         isEmptyCart.value = false;
//                         return CardSection(
//                           cartEntity: state.cartResonse!.cart!,
//                         );
//                       }
//                     }
//                     if (state.errorMessage != null) {
//                       final user = UserLocalStorage.getUser();
//
//                       if (user == null) {
//                         return CustumError(
//                           errorMessage: t.loginToEnjoyShopping,
//                         );
//                       } else {
//                         return CustumError();
//                       }
//                     } else {
//                       return CustumError();
//                     }
//                   },
//                 ),
//               ),
//
//               ValueListenableBuilder(
//                 valueListenable: isEmptyCart,
//                 builder: (context, value, child) {
//                   return Column(
//                     children: [
//                       if (!value) ...[
//                         ValueListenableBuilder(
//                           valueListenable: price,
//
//                           builder: (context, value, child) {
//                             return TotalCalculationPart(price: price.value);
//                           },
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.of(context).
//                                   pushNamed(AppRoutes.checkoutscreen);
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Text(
//                                     t.checkout,
//                                     style: getRegularStyle(
//                                       color: AppColors.white,
//                                       fontSize: FontSize.s16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/widgets/common_error.dart';
import 'package:flower_e_commerce/core/widgets/common_loading.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/card_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/delivery_location.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/empty_cart_view.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/total_calculation_part.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartViewModel cartViewModel = getIt.get<CartViewModel>();

  final ValueNotifier<int> price = ValueNotifier<int>(0);

  final ValueNotifier<bool> isEmptyCart = ValueNotifier<bool>(true);
  @override
  void initState() {
    cartViewModel.add(GetCartItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final user = UserLocalStorage.getUser();
    CartEntity? cartEntity;

    return BlocProvider.value(
      value: cartViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(t.cart),
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DeliveryLocation(),
              SizedBox(
                height: 430,
                child: BlocConsumer<CartViewModel, CartStates>(
                  listener: (context, state) {
                    final user = UserLocalStorage.getUser();

                    if (state.cartResonse != null && user != null) {
                      cartEntity = state.cartResonse!.cart;
                      if (state.cartResonse!.cart!.cartItems!.isEmpty) {

                        isEmptyCart.value = true;

                      } else {
                        isEmptyCart.value = false;
                      }
                      price.value = state.cartResonse!.cart!.totalPrice!;
                    } else {
                      isEmptyCart.value = true;
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading) {
                      return CommonLoading();
                    }
                    if (state.cartResonse != null && user != null) {
                      if (state.cartResonse!.cart!.cartItems!.isEmpty) {
                        isEmptyCart.value = true;
                        return EmptyCartView();
                      } else {
                        isEmptyCart.value = false;
                        return CardSection(
                          cartEntity: state.cartResonse!.cart!,
                        );
                      }
                    }
                    if (state.errorMessage != null) {
                      final user = UserLocalStorage.getUser();

                      if (user == null) {
                        return CustumError(
                          errorMessage: t.loginToEnjoyShopping,
                        );
                      } else {
                        return CustumError();
                      }
                    } else {
                      return CustumError();
                    }
                  },
                ),
              ),

              ValueListenableBuilder(
                valueListenable: isEmptyCart,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      if (!value) ...[
                        ValueListenableBuilder(
                          valueListenable: price,

                          builder: (context, value, child) {
                            return TotalCalculationPart(price: price.value);
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(AppRoutes.checkoutscreen,arguments: cartEntity);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    t.checkout,
                                    style: getRegularStyle(
                                      color: AppColors.white,
                                      fontSize: FontSize.s16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
