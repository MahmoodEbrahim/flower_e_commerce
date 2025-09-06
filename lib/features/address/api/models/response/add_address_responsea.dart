import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_responsea.g.dart';

@JsonSerializable()
class AddAddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "address")
  final Address? address;

  AddAddressResponse ({
    this.message,
    this.address,
  });

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) {
    return _$AddAddressResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddAddressResponseToJson(this);
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
  AddressEntity toEntity(){
    return AddressEntity(
      street: street,phone: phone,lat: lat,long: long,username: username,
      city: city,
    );
  }
}


