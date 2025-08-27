import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable{
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int? priceAfterDiscount;
  final int quantity;


  ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    this.priceAfterDiscount,
    required this.quantity,
  });

  int get discountPercentage {
    if (priceAfterDiscount! < price && price > 0) {
      return (((price - priceAfterDiscount!) / price) * 100).round();
    }
    return 0;
  }


  bool get inStock => quantity > 0;
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,title,description,images,imgCover,price,priceAfterDiscount,quantity
  ];
}