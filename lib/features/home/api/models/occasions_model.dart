import '../../domain/entity/occasions_entity.dart';

class OccasionsModel {
  OccasionsModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,});

  OccasionsModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSuperAdmin = json['isSuperAdmin'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool? isSuperAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['isSuperAdmin'] = isSuperAdmin;
    return map;
  }
  OccasionsEntity toEntity() {
    return OccasionsEntity(
      id: id,
      name: name,
      image: image,
    );
  }
}