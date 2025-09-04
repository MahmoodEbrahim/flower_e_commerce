import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';


Widget buildBestSellerList(
  List<BestSellerEntity>? bestSellers,
  BuildContext context,
) {
  final t = AppLocalizations.of(context)!;

  if (bestSellers == null || bestSellers.isEmpty) {
    return const NoProducts();
  }

  return SizedBox(
    height: 240,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bestSellers.length,
      itemBuilder: (context, index) {
        final bestSeller = bestSellers[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                product: bestSeller.toEntity(),
              ),
            ));
          },
          child: Container(
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    bestSeller.imgCover ?? '',
                    width: 140,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bestSeller.title ?? '',
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        '${bestSeller.price ?? 0} ${t.egp}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
