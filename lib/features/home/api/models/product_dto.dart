// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto extends Equatable {
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "id")
  final String? productModelId;

  const ProductDto({
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.productModelId,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
  static ProductModel toModel(ProductDto dto) {
    return ProductModel(
      rateAvg: dto.rateAvg,
      rateCount: dto.rateCount,
      id: dto.id,
      title: dto.title,
      slug: dto.slug,
      description: dto.description,
      imgCover: dto.imgCover,
      images: dto.images,
      price: dto.price,
      priceAfterDiscount: dto.priceAfterDiscount,
      quantity: dto.quantity,
      category: dto.category,
      occasion: dto.occasion,
      isSuperAdmin: dto.isSuperAdmin,
      sold: dto.sold,
      productModelId: dto.productModelId,
    );
  }

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
        createdAt,
        updatedAt,
        v,
        isSuperAdmin,
        sold,
        productModelId,
      ];
}
