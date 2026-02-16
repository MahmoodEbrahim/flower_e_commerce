// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaDataDto _$MetaDataDtoFromJson(Map<String, dynamic> json) => MetaDataDto(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      totalItems: (json['totalItems'] as num?)?.toInt(),
      someField: json['some_field'] as String?,
    );

Map<String, dynamic> _$MetaDataDtoToJson(MetaDataDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'totalItems': instance.totalItems,
      'some_field': instance.someField,
    };
