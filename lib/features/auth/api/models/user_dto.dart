import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';
@JsonSerializable()
class UserDto {
  @JsonKey(name: JsonSerlizableConstants.id)
  String? id;
  @JsonKey(name: JsonSerlizableConstants.firstName)
  String? firstName;
  @JsonKey(name: JsonSerlizableConstants.lastName)
  String? lastName;
  @JsonKey(name: JsonSerlizableConstants.email)
  String? email;
  @JsonKey(name: JsonSerlizableConstants.gender)
  String? gender;
  @JsonKey(name: JsonSerlizableConstants.phone)
  String? phone;
  @JsonKey(name: JsonSerlizableConstants.photo)
  String? photo;
  @JsonKey(name: JsonSerlizableConstants.role)
  String? role;
  @JsonKey(name: JsonSerlizableConstants.wishlist)
  List<dynamic>? wishlist;
  @JsonKey(name: JsonSerlizableConstants.addresses)
  List<dynamic>? addresses;
  @JsonKey(name: JsonSerlizableConstants.createdAt)
  DateTime? createdAt;
  UserDto({
    this.id,
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
  });
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
  UserModel toUserModel() {
    return UserModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        gender: gender,
        photo: photo,
        role: role,
        wishlist: wishlist,
        addresses: addresses
    );
  }
}