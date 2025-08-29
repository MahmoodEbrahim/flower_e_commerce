import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class OccasionsEntity {
  OccasionsEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  String? id;
  String? name;
  String? slug;
  String? image;
  ProductsEntity toEntity(){
    return ProductsEntity(
        id: id,imgCover: image,images: [image!,image!,image!],title: name
    );
}
}