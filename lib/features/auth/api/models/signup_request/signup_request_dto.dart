// To parse this JSON data, do
//
//     final signupRequestDto = signupRequestDtoFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'signup_request_dto.g.dart';

SignupRequestDto signupRequestDtoFromJson(String str) =>
    SignupRequestDto.fromJson(json.decode(str));

String signupRequestDtoToJson(SignupRequestDto data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SignupRequestDto extends Equatable {
  @JsonKey(name: JsonSerlizableConstants.firstName)
  String? firstName;

  @JsonKey(name: JsonSerlizableConstants.lastName)
  String? lastName;

  @JsonKey(name: JsonSerlizableConstants.email)
  String? email;

  @JsonKey(name: JsonSerlizableConstants.password)
  String? password;

  @JsonKey(name: JsonSerlizableConstants.rePassword)
  String? rePassword;

  @JsonKey(name: JsonSerlizableConstants.phone)
  String? phone;

  @JsonKey(name: JsonSerlizableConstants.gender)
  String? gender;

  SignupRequestDto({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.gender,
  });

  factory SignupRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestDtoToJson(this);

  static SignupRequestDto toDto(SignupRequestModel usermodel) {
    return SignupRequestDto(
        firstName: usermodel.firstName,
        lastName: usermodel.lastName,
        email: usermodel.email,
        phone: usermodel.phone,
        password: usermodel.password,
        rePassword: usermodel.repassword,
        gender: usermodel.gender);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        rePassword,
        phone,
        gender,
      ];
}
