import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteProductModel {
 @JsonKey(name: JsonSerlizableConstants.id)
String? id;

@JsonKey(name: JsonSerlizableConstants.title)
String? title;

@JsonKey(name: JsonSerlizableConstants.slug)
String? slug;

@JsonKey(name: JsonSerlizableConstants.description)
String? description;

@JsonKey(name: JsonSerlizableConstants.imgCover)
String? imgCover;

@JsonKey(name: JsonSerlizableConstants.images)
List<String>? images;

@JsonKey(name: JsonSerlizableConstants.price)
int? price;

@JsonKey(name: JsonSerlizableConstants.priceAfterDiscount)
int? priceAfterDiscount;

@JsonKey(name: JsonSerlizableConstants.quantity)
int? quantity;

@JsonKey(name: JsonSerlizableConstants.category)
String? category;

@JsonKey(name: JsonSerlizableConstants.occasion)
String? occasion;

@JsonKey(name: JsonSerlizableConstants.createdAt)
String? createdAt;

@JsonKey(name: JsonSerlizableConstants.updatedAt)
String? updatedAt;

@JsonKey(name: JsonSerlizableConstants.v)
int? v;

@JsonKey(name: JsonSerlizableConstants.isSuperAdmin)
bool? isSuperAdmin;

@JsonKey(name: JsonSerlizableConstants.sold)
int? sold;

@JsonKey(name: JsonSerlizableConstants.rateAvg)
int? rateAvg;

@JsonKey(name: JsonSerlizableConstants.rateCount)
int? rateCount;

  RemoteProductModel({
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
    this.rateAvg,
    this.rateCount,
  });

  factory RemoteProductModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteProductModelToJson(this);
 static ProductEntity toEntity(RemoteProductModel? model) {
    if (model == null) {
      return ProductEntity(
        id: '674511e790ab40a06854034b',
        title: 'Fake Product',
        slug: 'fake-product',
        description: 'This is a fake product description',
        imgCover: '44da12d8-4017-4e97-b654-ae76b5c8af48-cover_image.png',
        images: [
          "66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png",
          "f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png",
          "500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png",
        ],
        price: 999,
        priceAfterDiscount: 799,
        quantity: 10,
        category: '673c46fd1159920171827c85',
        occasion: '673b34c21159920171827ae0',
      );
    }

    return ProductEntity(
      id: model.id ?? '',
      title: model.title ?? '',
      slug: model.slug ?? '',
      description: model.description ?? '',
      imgCover: model.imgCover ?? '',
      images: model.images ?? [
          ""
        ],
      price: model.price ?? 0,
      priceAfterDiscount: model.priceAfterDiscount,
      quantity: model.quantity ?? 0,
      category: model.category ?? '',
      occasion: model.occasion ?? '',
    );
  }



  factory RemoteProductModel.fromEntity(ProductEntity entity) {
    return RemoteProductModel(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      description: entity.description,
      imgCover: entity.imgCover,
      images: entity.images,
      price: entity.price,
      priceAfterDiscount: entity.priceAfterDiscount,
      quantity: entity.quantity,
      category: entity.category,
      occasion: entity.occasion,
    );
  }


}
