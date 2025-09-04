import 'package:json_annotation/json_annotation.dart';

part 'upload_profile_photo_response.g.dart';

@JsonSerializable()
class UploadProfilePhotoResponse {
  @JsonKey(name: "message")
  final String? message;

  UploadProfilePhotoResponse ({
    this.message,
  });

  factory UploadProfilePhotoResponse.fromJson(Map<String, dynamic> json) {
    return _$UploadProfilePhotoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadProfilePhotoResponseToJson(this);
  }
}


