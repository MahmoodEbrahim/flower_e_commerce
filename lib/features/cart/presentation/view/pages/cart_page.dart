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
              onPressed: ()=>Navigator.of(context).pushNamed(AppRoutes.home),
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Column(
            children: [
              DeliveryLocation(),
              SizedBox(
                height: 400,
                child: BlocBuilder<CartViewModel, CartStates>(
                  builder: (context, state) {
                   
                    if (state.isLoading) {
                   
                      return CommonLoading();
                    }
                    if (state.products.isNotEmpty) {
                      return CardSection(products: state.products,);
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: SizedBox(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total"),
                        Text("100\$"),
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
                                color: AppColors.Black,
                                fontSize: FontSize.s16)),
                        Text(
                          "110\$",
                          style: getBoldStyle(
                              color: AppColors.Black, fontSize: FontSize.s16),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
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
