import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? rateAvg;
  final int? rateCount;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final bool? isSuperAdmin;
  final int? sold;
  final String? productModelId;

const  ProductModel({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.sold,
    this.productModelId,
  });

  @override
  List<Object?> get props => [
        rateAvg,
        rateCount,
        id,
        title,
        slug,
        description,
        imgCover,
        images,
        price,
        priceAfterDiscount,
        quantity,
        category,
        occasion,
        isSuperAdmin,
        sold,
        productModelId,
      ];
}
