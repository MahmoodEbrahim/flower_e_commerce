import 'package:json_annotation/json_annotation.dart';

part 'add_adress_request.g.dart';

@JsonSerializable()
class AddAdressRequest {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;

  AddAdressRequest ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddAdressRequest.fromJson(Map<String, dynamic> json) {
    return _$AddAdressRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddAdressRequestToJson(this);
  }
}


