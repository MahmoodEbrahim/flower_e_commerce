// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsModel _$OccasionsModelFromJson(Map<String, dynamic> json) =>
    OccasionsModel(
      Id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
    );

Map<String, dynamic> _$OccasionsModelToJson(OccasionsModel instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isSuperAdmin': instance.isSuperAdmin,
    };
