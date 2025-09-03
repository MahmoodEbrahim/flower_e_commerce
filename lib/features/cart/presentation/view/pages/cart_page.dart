import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/card_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/common_loading.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/delivery_location.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/total_calculation_part.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartViewModel cartViewModel = getIt.get<CartViewModel>();

  final ValueNotifier<int> price = ValueNotifier<int>(0);

  @override
  void initState() {
    cartViewModel.add(GetCartItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cartViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.White,
          title: Text("Cart"),
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Column(
            children: [
              DeliveryLocation(),
              SizedBox(
                height: 400,
                child: BlocConsumer<CartViewModel, CartStates>(
                  listener: (context, state) {
                    if (state.cartResonse != null) {
                      price.value = state.cartResonse!.cart!.totalPrice!;
                    }

                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage!)));

                      state.errorMessage = null;
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading) {
                      return CommonLoading();
                    }
                    if (state.cartResonse != null) {
                      return CardSection(
                        cartEntity: state.cartResonse!.cart!,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: price,
                  builder: (context, value, child) {
                    return TotalCalculationPart(
                      price: price.value,
                    );
                  }),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "CheckOut",
                              style: getRegularStyle(
                                  color: AppColors.White,
                                  fontSize: FontSize.s16),
                            ),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
