import 'package:json_annotation/json_annotation.dart';
import '../../../../../../core/utils/constants/json_serlizable_constants.dart';
part 'forget_password_response.g.dart';


@JsonSerializable()
class ForgetPasswordResponse {
  @JsonKey(name: JsonSerlizableConstants.messageJsonKey)
  final String? message;
  @JsonKey(name: JsonSerlizableConstants.infoJsonKey)
  final String? info;

  ForgetPasswordResponse ({
    this.message,
    this.info,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgetPasswordResponseToJson(this);
  }
}


