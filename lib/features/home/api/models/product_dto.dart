// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
    @JsonKey(name: "rateAvg")
    int? rateAvg;
    @JsonKey(name: "rateCount")
    int? rateCount;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "title")
    String? title;
    @JsonKey(name: "slug")
    String? slug;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "imgCover")
    String? imgCover;
    @JsonKey(name: "images")
    List<String>? images;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "priceAfterDiscount")
    int? priceAfterDiscount;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "category")
    String? category;
    @JsonKey(name: "occasion")
    String? occasion;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;
    @JsonKey(name: "isSuperAdmin")
    bool? isSuperAdmin;
    @JsonKey(name: "sold")
    int? sold;
    @JsonKey(name: "id")
    String? productModelId;

    ProductDto({
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

    factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

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

}
