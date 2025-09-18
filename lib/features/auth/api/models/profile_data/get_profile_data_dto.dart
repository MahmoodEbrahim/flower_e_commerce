import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_profile_data_dto.g.dart';

@JsonSerializable()
class GetProfileDataDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;

  GetProfileDataDto ({
    this.message,
    this.user,
  });

  factory GetProfileDataDto.fromJson(Map<String, dynamic> json) {
    return _$GetProfileDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProfileDataDtoToJson(this);
  }
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
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
  final List<Addresses>? addresses;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "passwordChangedAt")
  final String? passwordChangedAt;

  User ({
    this.Id,
    this.firstName,
    this.lastName,
    this.email,
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
  UserModel toEntity(){
    return UserModel(
      iid: Id,firstName: firstName,lastName: lastName,email: email,
      gender: gender,phone: phone,photo: photo,addresses:
    addresses!.map((e)=>e.toEntity()).toList(),wishlist: wishlist
    );
  }
}

@JsonSerializable()
class Addresses {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "_id")
  final String? Id;

  Addresses ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.Id,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return _$AddressesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressesToJson(this);
  }
  AddressEntity toEntity(){
    return AddressEntity(street: street,lat: lat,long: long,
    username: username,id: Id,phone: phone,city: city
    );
  }
}


