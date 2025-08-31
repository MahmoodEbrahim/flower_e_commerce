import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_flower_card.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key, this.allProducts});
  final List<ProductsEntity>? allProducts;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.allProducts, style: Theme.of(context).textTheme.titleLarge),
            Text(t.bloomWithOurExquisiteAllProducts,
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.6,
        ),
        itemCount: allProducts!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(product: allProducts![index])));
            },
            child: CustomCardFlower(
              newPrice: allProducts![index].priceAfterDiscount,
              image: allProducts![index].imgCover!,
              title: allProducts![index].title!,
              oldPrice: allProducts![index].price!,
            ),
          );
        },
      ),
    );
  }
}
