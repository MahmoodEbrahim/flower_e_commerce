import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/details_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/image_cart.dart';

import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  final CartEntity cartEntity;
  const CardSection({super.key, required this.cartEntity});

  @override
  Widget build(BuildContext context) {
    final cartItemList = cartEntity.cartItems;
    final price = cartEntity.totalPrice!;

    return ListView.builder(
        itemCount: cartItemList!.length,
        itemBuilder: (context, index) {
          final cartItem = cartItemList[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(color: AppColors.black[20]!)),
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    CardImage(
                      productImage: cartItem.product!.imgCover!,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DetailsSection(cartItem: cartItem,price:price),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
