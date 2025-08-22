import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verfiy_password_error_response.g.dart';

@JsonSerializable()
class VerfiyPasswordErrorResponse extends VerfiyPasswordResponse {
  @JsonKey(name: "error")
  final String? error;

  VerfiyPasswordErrorResponse ({
    this.error,
  });

  factory VerfiyPasswordErrorResponse.fromJson(Map<String, dynamic> json) {
    return _$VerfiyPasswordErrorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerfiyPasswordErrorResponseToJson(this);
  }
}


