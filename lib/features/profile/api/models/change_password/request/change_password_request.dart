import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: "password",required: true)
  final String password;
  @JsonKey(name: "newPassword",required: true)
  final String newPassword;

  ChangePasswordRequest ({
    required  this.password,
    required  this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordRequestToJson(this);
  }
}


