import 'package:json_annotation/json_annotation.dart';

part 'verfiy_password_response.g.dart';

@JsonSerializable()
class VerfiyPasswordResponse {
  @JsonKey(name: "status")
  final String? status;

  VerfiyPasswordResponse ({
    this.status,
  });

  factory VerfiyPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$VerfiyPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerfiyPasswordResponseToJson(this);
  }
}


