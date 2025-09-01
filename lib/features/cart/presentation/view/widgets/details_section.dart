import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';

import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final CartEntity cartEntity;
  final CartViewModel cartViewModel = getIt.get<CartViewModel>();
  DetailsSection({super.key, required this.cartEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                cartEntity.productModel.title!,
                style: getBoldStyle(
                    color: AppColors.Black, fontSize: FontSize.s16),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cartViewModel.add(
                        DeleteProductQuantityCartEvent(cartEntity: cartEntity));
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.red,
                  )),
            )
          ],
        ),
        Text(
          cartEntity.productModel.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EGP ${cartEntity.productModel.priceAfterDiscount ?? cartEntity.productModel.price} ',
              style:
                  getBoldStyle(color: AppColors.Black, fontSize: FontSize.s16),
            ),
            Row(
              children: [
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      cartViewModel.add(DecreaseProductQuantityCartEvent(
                          cartEntity: cartEntity));
                    },
                    icon: Icon(Icons.remove)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${cartEntity.stock}",
                    style: getBoldStyle(
                        color: AppColors.Black, fontSize: FontSize.s16),
                  ),
                ),
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      cartViewModel.add(IncreaseProductQuantityCartEvent(
                          cartEntity: cartEntity));
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ],
    );
  }
}
