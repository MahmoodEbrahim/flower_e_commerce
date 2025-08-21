import 'package:json_annotation/json_annotation.dart';

part 'reset_password_responsea.g.dart';

@JsonSerializable()
class ResetPasswordResponsea {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ResetPasswordResponsea ({
    this.message,
    this.token,
  });

  factory ResetPasswordResponsea.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordResponseaToJson(this);
  }
}


