import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class BestSellerEntity {
  BestSellerEntity({
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
  });
  String? id;
  String? title;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;

  ProductsEntity toEntity(){
    return ProductsEntity(
      id: id,imgCover: imgCover,images: images,price: price,description: description,
      priceAfterDiscount: priceAfterDiscount,quantity: quantity,category: category,
      occasion: occasion,title: title
    );
  }
}
