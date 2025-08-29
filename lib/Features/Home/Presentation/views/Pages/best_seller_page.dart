import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';



import '../../../../../config/theme/common_widgets/custom_flower_card.dart' ;

class BestSellerPage extends StatelessWidget{
  const BestSellerPage({super.key, this.bestSelller});
final List<BestSellerEntity>? bestSelller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Best seller",style: Theme.of(context).textTheme.titleLarge),
            Text("Bloom with our exquisite best sellers",style: Theme.of(context).textTheme.titleSmall)
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
        itemCount: bestSelller!.length,
        itemBuilder: (context, index) {
          return  GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsScreen(
                product: bestSelller![index].toEntity(),
              )));
            },
            child: CustomCardFlower(
              newPrice:bestSelller![index].priceAfterDiscount ,
              image: bestSelller![index].imgCover!, title: bestSelller![index]!.title!,
              oldPrice: bestSelller![index].price!,),
          );
        },
      ),

    );
  }

}
