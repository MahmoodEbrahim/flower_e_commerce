import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/utils/constants/json_serlizable_constants.dart';

part 'reset_password_responsea.g.dart';

@JsonSerializable()
class ResetPasswordResponsea {
  @JsonKey(name: JsonSerlizableConstants.messageJsonKey)
  final String? message;
  @JsonKey(name: JsonSerlizableConstants.tokenJsonKey)
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


