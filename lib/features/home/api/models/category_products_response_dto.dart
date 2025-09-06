// To parse this JSON data, do
//
//     final CategoryProductsResponseDtoresponseDto = responseDtoFromJson(jsonString);  
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';

import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'category_products_response_dto.g.dart';

CategoryProductsResponseDto responseDtoFromJson(String str) =>
    CategoryProductsResponseDto.fromJson(json.decode(str));

String responseDtoToJson(CategoryProductsResponseDto data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CategoryProductsResponseDto extends Equatable {
  @JsonKey(name: JsonSerlizableConstants.messageKey)
  final String? message;
  @JsonKey(name: JsonSerlizableConstants.metadataKey)
  final MetaDataDto? metadata;
  @JsonKey(name: JsonSerlizableConstants.productsKey)
  final List<ProductModel>? products;

  const CategoryProductsResponseDto({
    this.message,
    this.metadata,
    this.products,
  });

  factory CategoryProductsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductsResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, metadata, products];
}
