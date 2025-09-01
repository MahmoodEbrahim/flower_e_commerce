import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/card_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/common_loading.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/delivery_location.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final CartViewModel cartViewModel = getIt.get<CartViewModel>();
  ValueNotifier<int> price = ValueNotifier<int>(0);
  ValueNotifier<int> priceAfterFee = ValueNotifier<int>(0);

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
                   
                    if (state.price != null) {
                      
                      price.value = state.price!;
                      priceAfterFee.value = state.priceAfterFee!;
                    }
                  },
                  builder: (context, state) {
                    if (state.products.isNotEmpty || state.products.isEmpty) {
                      return CardSection(
                        products: state.products,
                      );
                    }
                    if (state.errorMessage != null) {
                      return Center(
                        child: Text(state.errorMessage!),
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
                      priceWithFee: priceAfterFee.value,
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

class TotalCalculationPart extends StatelessWidget {
  final int price;
  final int priceWithFee;
  const TotalCalculationPart({
    super.key,
    required this.price,
    required this.priceWithFee,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: SizedBox(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sub Total"),
              Text("$price\$"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Fee"),
              Text("10\$"),
            ],
          ),
          Divider(
            color: AppColors.black[20]!,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",
                  style: getBoldStyle(
                      color: AppColors.Black, fontSize: FontSize.s16)),
              Text(
                "$priceWithFee\$",
                style: getBoldStyle(
                    color: AppColors.Black, fontSize: FontSize.s16),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
