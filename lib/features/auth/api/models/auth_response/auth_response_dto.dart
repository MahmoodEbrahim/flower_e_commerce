// To parse this JSON data, do
//
//     final signupRequestDto = signupRequestDtoFromJson(jsonString);

import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'auth_response_dto.g.dart';

SignupResponseDto signupRequestDtoFromJson(String str) => SignupResponseDto.fromJson(json.decode(str));

String signupRequestDtoToJson(SignupResponseDto data) => json.encode(data.toJson());

@JsonSerializable()
class SignupResponseDto {
    @JsonKey(name: JsonSerlizableConstants.message)
    String? message;
    @JsonKey(name: JsonSerlizableConstants.user)
    UserDto? user;
    @JsonKey(name: JsonSerlizableConstants.token)
    String? token;

    SignupResponseDto({
        this.message,
        this.user,
        this.token,
    });

    factory SignupResponseDto.fromJson(Map<String, dynamic> json) => _$SignupResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$SignupResponseDtoToJson(this);
}

