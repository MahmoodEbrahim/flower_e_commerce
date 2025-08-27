import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasions_model.g.dart';

@JsonSerializable()
class OccasionsModel {
  @JsonKey(name: JsonSerlizableConstants.dashedIdKey)
  final String? Id;
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

  OccasionsModel ({
    this.Id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory OccasionsModel.fromJson(Map<String, dynamic> json) {
    return _$OccasionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OccasionsModelToJson(this);
  }

  OccasionsEntity toEntity() {
    return OccasionsEntity(
      id: Id,
      name: name,
      image: image,
    );
  }
}