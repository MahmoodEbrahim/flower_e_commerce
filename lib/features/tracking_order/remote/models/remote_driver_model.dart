import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/driver_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'remote_driver_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteDriverModel {
  @JsonKey(name: JsonSerlizableConstants.country)
  final String? country;
  @JsonKey(name: JsonSerlizableConstants.firstName)
  final String? firstName;
  @JsonKey(name: JsonSerlizableConstants.lastName)
  final String? lastName;
  @JsonKey(name: JsonSerlizableConstants.vehicleType)
  final String? vehicleType;
  @JsonKey(name: JsonSerlizableConstants.vehicleNumber)
  final String? vehicleNumber;
  @JsonKey(name: JsonSerlizableConstants.vehicleLicense)
  final String? vehicleLicense;
  @JsonKey(name: JsonSerlizableConstants.nid)
  final String? nId;
  @JsonKey(name: JsonSerlizableConstants.nidImg)
  final String? nIdImg;
  @JsonKey(name: JsonSerlizableConstants.email)
  final String? email;
  @JsonKey(name: JsonSerlizableConstants.gender)
  final String? gender;
  @JsonKey(name: JsonSerlizableConstants.phone)
  final String? phone;
  @JsonKey(name: JsonSerlizableConstants.photo)
  final String? photo;
  @JsonKey(name: JsonSerlizableConstants.role)
  final String? role;
  @JsonKey(name: JsonSerlizableConstants.id)
  final String? id;
  @JsonKey(name: JsonSerlizableConstants.createdAt)
  final String? createdAt;

  RemoteDriverModel({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nId,
    this.nIdImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  factory RemoteDriverModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteDriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDriverModelToJson(this);

  
  DriverEntity toEntity() {
    return DriverEntity(
      id: id ?? "",
      country: country ?? "",
      firstName: firstName ?? "",
      lastName: lastName ?? "",
      vehicleType: vehicleType ?? "",
      vehicleNumber: vehicleNumber ?? "",
      vehicleLicense: vehicleLicense ?? "",
      nid: nId ?? "",
      nidImg: nIdImg ?? "",
      email: email ?? "",
      gender: gender ?? "",
      phone: phone ?? "",
      photo: photo ?? "",
      role: role ?? "",
      createdAt: createdAt ?? "",
    );
  }


  factory RemoteDriverModel.fromEntity(DriverEntity entity) {
    return RemoteDriverModel(
      id: entity.id,
      country: entity.country,
      firstName: entity.firstName,
      lastName: entity.lastName,
      vehicleType: entity.vehicleType,
      vehicleNumber: entity.vehicleNumber,
      vehicleLicense: entity.vehicleLicense,
      nId: entity.nid,
      nIdImg: entity.nidImg,
      email: entity.email,
      gender: entity.gender,
      phone: entity.phone,
      photo: entity.photo,
      role: entity.role,
      createdAt: entity.createdAt,
    );
  }
}
