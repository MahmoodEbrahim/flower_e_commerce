// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_products_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryProductsResponseDto _$CategoryProductsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CategoryProductsResponseDto(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetaDataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryProductsResponseDtoToJson(
        CategoryProductsResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'products': instance.products,
    };
