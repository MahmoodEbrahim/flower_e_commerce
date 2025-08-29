import 'package:equatable/equatable.dart';

class ProductsEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;

  const ProductsEntity({
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

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imgCover,
        images,
        price,
        priceAfterDiscount,
        quantity,
        category,
        occasion,
      ];
}
