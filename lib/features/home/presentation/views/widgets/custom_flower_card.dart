import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomCardFlower extends StatelessWidget {
  const CustomCardFlower({
    super.key,
   
    required this.productsEntity
  });
  final ProductsEntity productsEntity;

  @override
  Widget build(BuildContext context) {
    int? discount;
    bool isThereDiscount = false;
    if (productsEntity.priceAfterDiscount != null) {
      isThereDiscount = true;
      double n = (productsEntity.priceAfterDiscount! / productsEntity.price!);
      discount = (n * 100).round();
    }
    final t = AppLocalizations.of(context)!;

    return Container(
      width: 163.0,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: AppColors.gray)),
      child: InkWell(
        onTap: () {
          
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                imageUrl: productsEntity.imgCover!,
                width: 147.0,
                height: 131.0,
                fit: BoxFit.cover,
                placeholder: (context, _) => Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.pink, size: 24)),
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
                productsEntity.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getRegularStyle(color: AppColors.black!, fontSize: 12.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isThereDiscount)
                    Text("${t.egp} ${productsEntity.priceAfterDiscount} ",
                        style: getBoldStyle(
                          color: AppColors.black!,
                          fontSize: FontSize.s16,
                        )),
                  Text("${productsEntity.price}",
                      style: isThereDiscount
                          ? getRegularStyle(
                              color: AppColors.black!,
                              fontSize: FontSize.s12,
                            ).copyWith(decoration: TextDecoration.lineThrough)
                          : getBoldStyle(
                              color: AppColors.black!,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cart,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        t.addToCart,
                        style:
                            getMediumStyle(color: AppColors.white, fontSize: 13.0),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
