import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/common_widgets/custom_flower_card.dart';

class TestProductsScreen extends StatelessWidget {
  const TestProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyProducts = [
      ProductsEntity(
        id: "1",
        title: "Red Roses",
        description: "Beautiful red roses bouquet",
        price: 600,
        priceAfterDiscount: 500,
        images: [ "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
          "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
          "https://flower.elevateegy.com/uploads/3594e620-5411-4c6f-bf4f-188e312ee391-image_three.png",
          "https://flower.elevateegy.com/uploads/8cfb2f72-c8e8-47f6-bf10-70f43b3e0fed-image_two.png"
        ],
        imgCover: 'https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png',
        quantity: 88,
      ),
      ProductsEntity(
          id: "2",
          title: "White Tulips",
          description: "Elegant white tulips",
          price: 450,
          images: ["https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png",
            "https://flower.elevateegy.com/uploads/f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png",
            "https://flower.elevateegy.com/uploads/500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png"],
          imgCover: "https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png",
          quantity: 0,
          priceAfterDiscount: 200
      ),
    ];

    return Scaffold(
      backgroundColor:AppColors.White,
      appBar: AppBar(title: const Text("Test Products")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: dummyProducts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: CustomCardFlower(title: dummyProducts[index].title!,
              newPrice: dummyProducts[index].priceAfterDiscount,
              oldPrice: dummyProducts[index].price!,
              image: dummyProducts[index].imgCover!,),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.details,
                    arguments: dummyProducts[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
