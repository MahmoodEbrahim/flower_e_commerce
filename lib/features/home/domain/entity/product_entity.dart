import 'package:equatable/equatable.dart';

class ProductsEntity  extends Equatable {
  ProductsEntity({
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
  @override
  // TODO: implement props
  List<Object?> get props => [id,title,description,imgCover,images,price,priceAfterDiscount,quantity,category,occasion];
}
