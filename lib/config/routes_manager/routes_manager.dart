import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';

import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

import 'package:flower_e_commerce/features/home/presentation/views/pages/categories_page.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_details_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/home_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static List<CategoriesEntity> fakeCategories = [
    CategoriesEntity(
      id: "673c479e1159920171827c99",
      name: "flowers",

      image:
          "https://flower.elevateegy.com/uploads/39c641a6-4ec4-421a-8f55-5d8f5eeba5c3-flowers.png",

    ),
    CategoriesEntity(
      id: "673c47441159920171827c8d",
      name: "cards",

      image:
          "https://flower.elevateegy.com/uploads/06dfd914-95b2-4832-91d1-9affabe9fbd6-card.png",

    ),
    CategoriesEntity(
      id: "673c479e1159920171827c99",
      name: "chocolate",

      image:
          "https://flower.elevateegy.com/uploads/4a6586c0-9b1b-4009-b8c0-121de16f0bea-chocolate.png",

    ),
    CategoriesEntity(
      id: "673c472f1159920171827c8a",
      name: "gifts",

      image:
          "https://flower.elevateegy.com/uploads/79af9251-8534-4d50-8346-160f30589268-gift.png",

    ),
    CategoriesEntity(
      id: "673c4a851159920171827ca4",
      name: "Candles & Diffusers",

      image:
          "https://flower.elevateegy.com/uploads/cbeff909-1711-4f77-9861-76bf6acc74eb-Candles & Diffusers.png",

    ),
    CategoriesEntity(
      id: "673c47751159920171827c93",
      name: "perfumes",

      image:
          "https://flower.elevateegy.com/uploads/eac4f4a6-da5e-4e4a-8223-0f1a7a9993c6-perfumes.png",

    ),
    CategoriesEntity(
      id: "673c4a551159920171827c9e",
      name: "Cakes",

      image:
          "https://flower.elevateegy.com/uploads/8cf2d065-2e52-490a-9a8c-1b75edd5633a-cakes.png",

    ),
    CategoriesEntity(
      id: "673c47591159920171827c90",
      name: "Jewellery",

      image:
          "https://flower.elevateegy.com/uploads/381400d6-95e3-4dcc-811f-2ff430c53d21-Jewellery.png",

    ),
    CategoriesEntity(
      id: "673c47881159920171827c96",
      name: "watches",

      image:
          "https://flower.elevateegy.com/uploads/98d9daf2-d4d8-4cf8-91ae-7f7d35ddb22c-watches.png",

    ),
    CategoriesEntity(
      id: "673c4a6f1159920171827ca1",
      name: "Plants",

      image:
          "https://flower.elevateegy.com/uploads/ebc124bd-979d-4d7a-abcf-e87d6ef388bf-plants.png",

    ),
    CategoriesEntity(
      id: "68a9c198a8bca307f9dfc863",
      name: "gaming2",

      image:
          "https://flower.elevateegy.com/uploads/0a181760-99b1-4f71-b12d-6406a3551ce2-1d86d2292b00d8f9f595b77b0f15512a2814eb15.png",

    ),
    CategoriesEntity(
      id: "68aa161ba8bca307f9dff600",
      name: "box gifts",

      image:
          "https://flower.elevateegy.com/uploads/07322de7-dd97-48c2-a964-7d7cd012a665-5d249a374fcf9f813beebe730fa7770febca61d2.png",

    ),
  ];

  static List<ProductsEntity> fakeProducts = [
    ProductsEntity(

      id: "673e2e1f1159920171828153",
      title: "Dreamy White Roses Bouquet",

      description:
          "Elevate any celebration with our luxury rose bouquet. This exquisite arrangement features pristine white roses wrapped in a sophisticated dark teal wrap, creating a stunning visual contrast. Perfect for celebrations, anniversaries, or as a heartfelt gift, this bouquet combines timeless elegance with modern style. Make a memorable impression with this luxurious floral arrangement. Buy now to delight your loved ones with the beauty and grace of these premium roses.",
      imgCover:
          "https://flower.elevateegy.com/uploads/2d8ddf11-935f-4a45-a100-e1e0765a39c3-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
        "https://flower.elevateegy.com/uploads/66fc9304-3ceb-4b73-97dd-730ccf790c49-image_three.png",
        "https://flower.elevateegy.com/uploads/acf9531b-5ca9-4c45-97fc-f81df9d62091-image_two.png"
      ],
      price: 320,
      priceAfterDiscount: 199,
      quantity: -1,
      category: "673c46fd1159920171827c85",
      occasion: "673b35c01159920171827aed",


    ),
    ProductsEntity(

      id: "6745096c90ab40a0685402fc",
      title: "Forever Pink | Baby Roses",

      description:
          "A gift of pink baby roses holds profound meaning. It symbolizes love, gratitude, and appreciation, making it a perfect choice for any occasion. The soft, feminine hue of pink baby roses embodies notions of nurturing and emotional love. They are also a gentle way to express sympathy or convey a message filled with kindness. These pink baby roses represent a significant gesture of love or a heartfelt wish for good luck and happiness. Embrace the power of pink roses to convey your emotions and leave a lasting impression.",
      imgCover:
          "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
        "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
        "https://flower.elevateegy.com/uploads/3594e620-5411-4c6f-bf4f-188e312ee391-image_three.png",
        "https://flower.elevateegy.com/uploads/8cfb2f72-c8e8-47f6-bf10-70f43b3e0fed-image_two.png"
      ],
      price: 2049,
      priceAfterDiscount: 1899,
      quantity: 4741,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",


    ),
    ProductsEntity(

      id: "673e1cd711599201718280fb",
      title: "Wdding Flower",

      description: "This is a Pack of White Widding Flowers",
      imgCover:
          "https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png",
        "https://flower.elevateegy.com/uploads/f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png",
        "https://flower.elevateegy.com/uploads/500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png"
      ],
      price: 250,
      priceAfterDiscount: 100,
      quantity: -65,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",

    ),
    ProductsEntity(

      id: "674503f390ab40a0685402db",
      title: "Red & Pink Roses",

      description:
          "Beautiful arrangement of red and pink roses, ideal for anniversaries and romantic gestures.",
      imgCover: "https://flower.elevateegy.com/uploads/123-cover.png",
      images: [
        "https://flower.elevateegy.com/uploads/1231.png",
        "https://flower.elevateegy.com/uploads/1232.png"
      ],
      price: 350,
      priceAfterDiscount: 299,
      quantity: 100,
      category: "673c46fd1159920171827c85",
      occasion: "673b35c01159920171827aed",


    ),
    ProductsEntity(

      id: "6745045c90ab40a0685402dd",
      title: "Sunflower Delight",

      description:
          "A cheerful bouquet of sunflowers, perfect for brightening up any space.",
      imgCover: "https://flower.elevateegy.com/uploads/sunflower-cover.png",
      images: [
        "https://flower.elevateegy.com/uploads/sunflower1.png",
        "https://flower.elevateegy.com/uploads/sunflower2.png"
      ],
      price: 180,
      priceAfterDiscount: 150,
      quantity: 200,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",


    ),
    ProductsEntity(


      id: "674504b490ab40a0685402de",
      title: "Orchid Elegance",

      description:
          "Elegant orchids in a stylish arrangement, ideal for corporate gifts or home decor.",
      imgCover: "https://flower.elevateegy.com/uploads/orchid-cover.png",
      images: [
        "https://flower.elevateegy.com/uploads/orchid1.png",
        "https://flower.elevateegy.com/uploads/orchid2.png"
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 50,
      category: "673c46fd1159920171827c85",
      occasion: "673b35c01159920171827aed",


    ),
    ProductsEntity(


      id: "6745050d90ab40a0685402df",
      title: "Tulip Spring Mix",

      description:
          "Vibrant tulips in assorted colors, bringing the freshness of spring indoors.",
      imgCover: "https://flower.elevateegy.com/uploads/tulip-cover.png",
      images: [
        "https://flower.elevateegy.com/uploads/tulip1.png",
        "https://flower.elevateegy.com/uploads/tulip2.png"
      ],
      price: 220,
      priceAfterDiscount: 199,
      quantity: 300,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",


    ),
    ProductsEntity(


      id: "6745055f90ab40a0685402e0",
      title: "Lavender Serenity",

      description:
          "A calming bouquet of lavender, perfect for relaxation and home decor.",
      imgCover: "https://flower.elevateegy.com/uploads/lavender-cover.png",
      images: [
        "https://flower.elevateegy.com/uploads/lavender1.png",
        "https://flower.elevateegy.com/uploads/lavender2.png"
      ],
      price: 300,
      priceAfterDiscount: 279,
      quantity: 150,
      category: "673c46fd1159920171827c85",
      occasion: "673b35c01159920171827aed",


    ),
  ];

  static Route onGenerate(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');

    switch (url.path) {


      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => HomePage());
      case AppRoutes.catergories:
        return MaterialPageRoute(
            builder: (context) => CategoriesPage(
              categoryList: fakeCategories,
              produdctsList: fakeProducts,
            ));

      case AppRoutes.details:
        final product = settings.arguments as ProductsEntity;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(  product: product,),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("No Route Page")),
        );
    }
  }
}
