import 'package:json_annotation/json_annotation.dart';
import '../../../../../../core/utils/constants/json_serlizable_constants.dart';
part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: JsonSerlizableConstants.emailJsonKey)
  final String? email;
  @JsonKey(name: JsonSerlizableConstants.newPasswordJsonKey)
  final String? newPassword;

  ResetPasswordRequest ({
    this.email,
    this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestToJson(this);
  }
}


