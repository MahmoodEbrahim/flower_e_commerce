import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
  final PageController controller = PageController();
  final ProductsEntity? product;

  final CartViewModel cartViewModel = getIt.get<CartViewModel>();

  ProductDetailsScreen({super.key, this.product});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.lightPink,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 35,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.lightPink,
                margin: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: 300,
                      height: 550,
                      child: PageView(
                        controller: controller,
                        children: product!.images!
                            .map((imageUrl) => AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: Image.network(imageUrl,
                                      fit: BoxFit.contain),
                                ))
                            .toList(),
                      ),
                    )),
                    SizedBox(height: 8),
                    SmoothPageIndicator(
                      controller: controller,
                      count: product!.images!.length,
                      effect: ScrollingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        dotColor: AppColors.whiteColor[70] ?? AppColors.white,
                        activeDotColor: AppColors.pink,
                        activeDotScale: 1.3,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${locale.egp} ${product!.price}",
                          style: getSemiBoldStyle(
                              color: AppColors.black, fontSize: FontSize.s20)),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: locale.status,
                            style: getBoldStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s20)),
                        TextSpan(
                            text: (product!.quantity! <= 0)
                                ? locale.outOfStock
                                : locale.inStock,
                            style: getMediumStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s16)),
                      ]))
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(locale.includeTax,
                      style: getRegularStyle(
                          color: AppColors.gray, fontSize: FontSize.s13)),
                  SizedBox(height: 5),
                  Text("${product!.title}",
                      style: getBoldStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height: 15),
                  Text(locale.description,
                      style: getBoldStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height: 5),
                  Text("${product!.description}",
                      style: getMediumStyle(
                          color: AppColors.black, fontSize: FontSize.s16)),
                  SizedBox(height: 90),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        CartItemRequestEntity cartItemRequestEntity =
                            CartItemRequestEntity(
                              product: product!.id,
                              quantity: 1

                            );
                        // go to cart

                        cartViewModel.add(AddToCartEvent(
                            cartItemRequestEntity: cartItemRequestEntity));
                      },
                      child: Text(locale.addToCart,
                          style: getMediumStyle(
                              color: AppColors.white, fontSize: FontSize.s18)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
