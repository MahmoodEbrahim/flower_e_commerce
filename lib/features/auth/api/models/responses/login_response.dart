import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDTO? user;
  @JsonKey(name: "token")
  final String? token;

  LoginResponse ({
    this.message,
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseToJson(this);
  }
  
  LoginEntity toLoginEntity(){
    return LoginEntity(user: user!.toUserEntity(),token: token??"" );
  }
}


