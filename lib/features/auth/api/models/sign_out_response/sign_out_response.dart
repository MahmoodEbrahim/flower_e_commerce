import 'package:json_annotation/json_annotation.dart';

part 'sign_out_response.g.dart';

@JsonSerializable()
class SignOutResponse {
  @JsonKey(name: "message")
  final String? message;

  SignOutResponse ({
    this.message,
  });

  factory SignOutResponse.fromJson(Map<String, dynamic> json) {
    return _$SignOutResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignOutResponseToJson(this);
  }
}


