import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remove_address_dto.g.dart';

@JsonSerializable()
class RemoveAddressDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "address")
  final List<Address>? address;

  RemoveAddressDto({
    this.message,
    this.address,
  });

  factory RemoveAddressDto.fromJson(Map<String, dynamic> json) =>
      _$RemoveAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveAddressDtoToJson(this);
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
  final String? id;

  Address({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }


  factory Address.fromEntity(AddressEntity entity) {
    return Address(
      id: entity.id,
      street: entity.street,
      phone: entity.phone,
      city: entity.city,
      lat: entity.lat,
      long: entity.long,
      username: entity.username,
    );
  }


  Address copyWith({
    String? id,
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    String? username,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      username: username ?? this.username,
    );
  }
}
