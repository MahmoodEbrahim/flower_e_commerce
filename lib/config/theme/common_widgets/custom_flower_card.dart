import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../features/home/domain/entity/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCardFlower extends StatelessWidget {
  ProductsEntity product;

   CustomCardFlower({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    int? discount;
    bool isThereDiscount = false;
    if (product.priceAfterDiscount != null && product.price != null) {
      isThereDiscount = true;
      final price = product.price!.toDouble();
      final discounted = product.priceAfterDiscount!.toDouble();
      discount = (((price - discounted) / price) * 100).round();
    }
    final t = AppLocalizations.of(context)!;
    return Container(
      width: 163.0,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 1.0, color: AppColors.midGray)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: product.imgCover!,
            width: 147.0,
            height: 131.0,
            fit: BoxFit.cover,
            placeholder: (context, _) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, _, error) => Center(
              child: Icon(
                Icons.image_not_supported_rounded,
                color: AppColors.gray,
                size: 24.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            product.title!,
            style: getRegularStyle(color: AppColors.black[60]!, fontSize: 12.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isThereDiscount)
                Text("EGP ${product.priceAfterDiscount} ",
                    style: getBoldStyle(
                      color: AppColors.black[60]!,
                      fontSize: FontSize.s16,
                    )),
              Text("${product.price}",
                  style: isThereDiscount
                      ? getRegularStyle(
                          color: AppColors.black[60]!,
                          fontSize: FontSize.s12,
                        ).copyWith(decoration: TextDecoration.lineThrough)
                      : getBoldStyle(
                          color: AppColors.black[60]!,
                          fontSize: FontSize.s16,
                        )),
              if (isThereDiscount)
                Text(
                  "$discount%",
                  style:
                      getRegularStyle(color: AppColors.green, fontSize: 12.0),
                ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.cart,
                    color: AppColors.White,
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(
                    t.add_to_cart,
                    style:
                        getMediumStyle(color: AppColors.White, fontSize: 13.0),
                  )
                ],
              ))
        ],
      ),
    );
  }
}