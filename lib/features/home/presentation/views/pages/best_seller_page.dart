import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/core/utils/constants/string_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/common_widgets/custom_flower_card.dart' ;

class BestSeller extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   // ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringsManager.bestseller,style: Theme.of(context).textTheme.titleLarge),
            Text(StringsManager.bestseller2,style: Theme.of(context).textTheme.titleSmall)
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
        itemCount: 6,
        itemBuilder: (context, index) {
          return const CustomCardFlower(title:StringsManager.cardtitle,oldPrice: 800,image: AssetsManager.cardPhoto, newPrice: 600,discount: 20,);
        },
      ),

    );
  }

}