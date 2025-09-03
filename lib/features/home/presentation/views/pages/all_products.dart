import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';

import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/core/utils/constants/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/common_widgets/custom_flower_card.dart' ;

class AllProductsPage extends StatelessWidget{
  AllProductsPage({this.allProducts});
  List<ProductsEntity>? allProducts;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Products",style: Theme.of(context).textTheme.titleLarge),
            Text("Bloom with our exquisite all Products",style: Theme.of(context).textTheme.titleSmall)
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
          return  GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsScreen(
                product: allProducts![index]
              )));
            },
            child: CustomCardFlower(
              newPrice:allProducts![index].priceAfterDiscount ,
              image: allProducts![index].imgCover!, title: allProducts![index]!.title!,
              oldPrice: allProducts![index].price!,),
          );
        },
      ),

    );
  }

}
