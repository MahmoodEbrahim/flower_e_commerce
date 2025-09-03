// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['password', 'newPassword'],
  );
  return ChangePasswordRequest(
    password: json['password'] as String,
    newPassword: json['newPassword'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'newPassword': instance.newPassword,
    };
