import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  @JsonKey(name: JsonSerlizableConstants.message)
  final String? message;
  @JsonKey(name: JsonSerlizableConstants.user)
  final UserDto? user;
  @JsonKey(name: JsonSerlizableConstants.token)
  final String? token;

  AuthResponseDto ({
    this.message,
    this.user,
    this.token,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthResponseDtoToJson(this);
  }

  LoginModel toLoginEntity(){
    return LoginModel(user: user!.toUserModel(),token: token??"" );
  }
}




/////////////////////////////////
