import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/details_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/image_cart.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardSection extends StatelessWidget {
  final List<ProductsEntity> products;
  const CardSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(color: AppColors.black[20]!)),
            width: double.infinity,
            child: InkWell(
              onTap: (){},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    CardImage(
                      productImage: product.imgCover!,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DetailsSection(product: product),
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
