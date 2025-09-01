import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final ProductsEntity product;
  const DetailsSection({
    super.key,
    required this.product
  });

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
                product.title!,
                style:
                    getBoldStyle(color: AppColors.Black, fontSize: FontSize.s16),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.red,
                  )),
            )
          ],
        ),
        Text(product.title!,  maxLines: 1,
            overflow: TextOverflow.ellipsis,),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EGP ${product.priceAfterDiscount??product.price} '
              ,
              style:
                  getBoldStyle(color: AppColors.Black, fontSize: FontSize.s16),
            ),
            Row(
              children: [
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.remove)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "1",
                    style: getBoldStyle(
                        color: AppColors.Black, fontSize: FontSize.s16),
                  ),
                ),
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ],
    );
  }
}
