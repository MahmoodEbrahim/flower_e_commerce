import 'package:json_annotation/json_annotation.dart';

part 'remove_address_dto.g.dart';

@JsonSerializable()
class RemoveAddressDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "address")
  final List<Address>? address;

  RemoveAddressDto ({
    this.message,
    this.address,
  });

  factory RemoveAddressDto.fromJson(Map<String, dynamic> json) {
    return _$RemoveAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RemoveAddressDtoToJson(this);
  }
}

@JsonSerializable()
class Address {
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
  @JsonKey(name: "_id")
  final String? Id;

  Address ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.Id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressToJson(this);
  }
}


