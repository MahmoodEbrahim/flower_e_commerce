import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response.g.dart';

@JsonSerializable()
class EditProfileResponsea {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;

  EditProfileResponsea ({
    this.message,
    this.user,
  });

  factory EditProfileResponsea.fromJson(Map<String, dynamic> json) {
    return _$EditProfileResponseaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileResponseaToJson(this);
  }
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "wishlist")
  final List<dynamic>? wishlist;
  @JsonKey(name: "addresses")
  final List<dynamic>? addresses;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "passwordChangedAt")
  final String? passwordChangedAt;

  User ({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
    this.passwordChangedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}


