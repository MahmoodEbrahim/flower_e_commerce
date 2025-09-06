import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_address_response.g.dart';

@JsonSerializable()
class GetAllAddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<Addresses>? addresses;

  GetAllAddressResponse ({
    this.message,
    this.addresses,
  });

  factory GetAllAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAllAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllAddressResponseToJson(this);
  }
}

@JsonSerializable()
class Addresses {
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

  Addresses ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.Id,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return _$AddressesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressesToJson(this);
  }
  AddressEntity toEntity(){
    return AddressEntity(
      street: street,phone: phone,lat: lat,long: long,username: username,
      city: city,
    );
  }
}


