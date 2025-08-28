import 'package:flower_e_commerce/config/theme/common_widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_details_entity.dart';
import 'package:flutter/cupertino.dart';
class OccasionGrid extends StatelessWidget {
  final List<ProductDetailsEntity>occasion;
  const OccasionGrid({super.key, required this.occasion});
  @override
  Widget build(BuildContext context) {
    return  GridView.builder
      (
        itemCount: occasion.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 163/240
    ), itemBuilder: (context,index){
      return CustomCardFlower(
image: occasion[index].imgCover!,title: occasion[index].title,
        newPrice: occasion[index].priceAfterDiscount,

        oldPrice: occasion[index].price??900,

      );
    });
  }
}
