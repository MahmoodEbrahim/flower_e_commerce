import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  @JsonKey(name: JsonSerlizableConstants.dashedIdKey)
  final String? iid;
  @JsonKey(name: JsonSerlizableConstants.nameKey)
  final String? name;
  @JsonKey(name: JsonSerlizableConstants.slugKey)
  final String? slug;
  @JsonKey(name: JsonSerlizableConstants.imageKey)
  final String? image;
  @JsonKey(name: JsonSerlizableConstants.createdAtKey)
  final String? createdAt;
  @JsonKey(name: JsonSerlizableConstants.updatedAtKey)
  final String? updatedAt;
  @JsonKey(name: JsonSerlizableConstants.isSuperAdminKey)
  final bool? isSuperAdmin;

  CategoriesModel ({
    this.iid,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return _$CategoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesModelToJson(this);
  }

  CategoriesEntity toEntity() {
    return CategoriesEntity(
      id: iid,
      name: name,
      image: image,
    );
  }
}