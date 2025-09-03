import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bestseller_model.g.dart';

@JsonSerializable()
class BestsellerModel {
  @JsonKey(name: JsonSerlizableConstants.rateAvgKey)
  final int? rateAvg;
  @JsonKey(name: JsonSerlizableConstants.rateCountKey)
  final int? rateCount;
  @JsonKey(name: JsonSerlizableConstants.dashedIdKey)
  final String? Id;
  @JsonKey(name: JsonSerlizableConstants.titleKey)
  final String? title;
  @JsonKey(name: JsonSerlizableConstants.slugKey)
  final String? slug;
  @JsonKey(name: JsonSerlizableConstants.descriptionKey)
  final String? description;
  @JsonKey(name: JsonSerlizableConstants.imgCoverKey)
  final String? imgCover;
  @JsonKey(name: JsonSerlizableConstants.imagesKey)
  final List<String>? images;
  @JsonKey(name: JsonSerlizableConstants.priceKey)
  final int? price;
  @JsonKey(name: JsonSerlizableConstants.priceAfterDiscountKey)
  final int? priceAfterDiscount;
  @JsonKey(name: JsonSerlizableConstants.quantityKey)
  final int? quantity;
  @JsonKey(name: JsonSerlizableConstants.categoryKey)
  final String? category;
  @JsonKey(name: JsonSerlizableConstants.occasionKey)
  final String? occasion;
  @JsonKey(name: JsonSerlizableConstants.createdAtKey)
  final String? createdAt;
  @JsonKey(name: JsonSerlizableConstants.updatedAtKey)
  final String? updatedAt;
  @JsonKey(name: JsonSerlizableConstants.vKey)
  final int? v;
  @JsonKey(name: JsonSerlizableConstants.isSuperAdminKey)
  final bool? isSuperAdmin;
  @JsonKey(name: JsonSerlizableConstants.soldKey)
  final int? sold;
  @JsonKey(name: JsonSerlizableConstants.idKey)
  final String? id;

  BestsellerModel ({
    this.rateAvg,
    this.rateCount,
    this.Id,
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
    this.id,
  });

  factory BestsellerModel.fromJson(Map<String, dynamic> json) {
    return _$BestsellerModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestsellerModelToJson(this);
  }

  BestSellerEntity toEntity() {
    return BestSellerEntity(
      id: id,
      title: title,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
    );
  }
}