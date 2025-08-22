import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/utils/constants/json_serlizable_constants.dart';

part 'verfiy_password_response.g.dart';

@JsonSerializable()
class VerfiyPasswordResponse {
  @JsonKey(name: JsonSerlizableConstants.statusJsonKey)
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


