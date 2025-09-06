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

  ProductsEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? quantity,
    String? category,
    String? occasion,
  }) {
    return ProductsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imgCover: imgCover ?? this.imgCover,
      images: images ?? this.images,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      occasion: occasion ?? this.occasion,
    );
  }

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
