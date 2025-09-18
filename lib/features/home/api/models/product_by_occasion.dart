import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_by_occasion.g.dart';

@JsonSerializable()
class ProductByOccasionDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaDataDto? metadata;
  @JsonKey(name: "products")
  final List<ProductModel>? products;
  ProductByOccasionDto ({
    this.message,
    this.metadata,
    this.products,
  });

  factory ProductByOccasionDto.fromJson(Map<String, dynamic> json) {
    return _$ProductByOccasionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductByOccasionDtoToJson(this);
  }
}



