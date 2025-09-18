import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_model.dart';

part 'logged_in_user_dto.g.dart';

@JsonSerializable()
class LoggedInUserDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? userDto;

  LoggedInUserDto ({
    this.message,
    this.userDto,
  });

  factory LoggedInUserDto.fromJson(Map<String, dynamic> json) {
    return _$LoggedInUserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoggedInUserDtoToJson(this);
  }

  UserModel toUserModel() {
    return userDto?.toUserModel() ?? UserModel();
  }

}


