// To parse this JSON data, do
//
//     final CategoryProductsResponseDtoresponseDto = responseDtoFromJson(jsonString);

import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'category_products_response_dto.g.dart';

CategoryProductsResponseDto responseDtoFromJson(String str) => CategoryProductsResponseDto.fromJson(json.decode(str));

String responseDtoToJson(CategoryProductsResponseDto data) => json.encode(data.toJson());

@JsonSerializable()
class CategoryProductsResponseDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "metadata")
    MetaDataDto? metadata;
    @JsonKey(name: "products")
    List<ProductDto>? products;

    CategoryProductsResponseDto({
        this.message,
        this.metadata,
        this.products,
    });

    factory CategoryProductsResponseDto.fromJson(Map<String, dynamic> json) => _$CategoryProductsResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CategoryProductsResponseDtoToJson(this);
}

