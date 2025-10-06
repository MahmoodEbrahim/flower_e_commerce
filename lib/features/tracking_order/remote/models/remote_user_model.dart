import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteUserModel {
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

@JsonKey(name: JsonSerlizableConstants.passwordChangedAt)
String? passwordChangedAt;

@JsonKey(name: JsonSerlizableConstants.passwordResetCode)
String? passwordResetCode;

@JsonKey(name: JsonSerlizableConstants.passwordResetExpires)
String? passwordResetExpires;

@JsonKey(name: JsonSerlizableConstants.resetCodeVerified)
bool? resetCodeVerified;

  RemoteUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  factory RemoteUserModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteUserModelToJson(this);

  static UserEntity toEntity(RemoteUserModel? model) {
    if (model == null) {
      return  UserEntity(
        id: 'fake-user-id',
        firstName: 'Fake',
        lastName: 'User',
        email: 'fake@email.com',
        gender: 'unknown',
        phone: '0000000000',
        photo: 'https://flower.elevateegy.com/uploads/default-profile.png',
      );
    }

    return UserEntity(
      id: model.id ?? 'fake-user-id',
      firstName: model.firstName ?? 'Fake',
      lastName: model.lastName ?? 'User',
      email: model.email ?? 'fake@email.com',
      gender: model.gender ?? 'unknown',
      phone: model.phone ?? '0000000000',
      photo: model.photo ?? 'https://example.com/default-profile.png',
    );
  }

  factory RemoteUserModel.fromEntity(UserEntity entity) {
    return RemoteUserModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      gender: entity.gender,
      phone: entity.phone,
      photo: entity.photo,
    );
  }
}
