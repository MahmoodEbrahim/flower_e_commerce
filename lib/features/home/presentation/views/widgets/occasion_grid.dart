import 'package:flower_e_commerce/features/home/presentation/views/widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';
class OccasionGrid extends StatelessWidget {
  final List<ProductsEntity>occasion;
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
      return GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
              ProductDetailsScreen(product: occasion[index])));
        },
        child: CustomCardFlower(
        productsEntity: occasion[index],

        )
      );
        
    });
  }
}
