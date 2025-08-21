import 'package:json_annotation/json_annotation.dart';

part 'verfiy_password_request.g.dart';

@JsonSerializable()
class VerfiyPasswordRequest {
  @JsonKey(name: "resetCode")
  final String? resetCode;

  VerfiyPasswordRequest ({
    this.resetCode,
  });

  factory VerfiyPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$VerfiyPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerfiyPasswordRequestToJson(this);
  }
}


