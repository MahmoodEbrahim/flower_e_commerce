import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/store_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'remote_store_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteStoreModel {
 @JsonKey(name: JsonSerlizableConstants.name)
String? name;

@JsonKey(name: JsonSerlizableConstants.image)
String? image;

@JsonKey(name: JsonSerlizableConstants.address)
String? address;

@JsonKey(name: JsonSerlizableConstants.phoneNumber)
String? phoneNumber;

@JsonKey(name: JsonSerlizableConstants.latLong)
LatLng? latLong;

  RemoteStoreModel({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory RemoteStoreModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteStoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteStoreModelToJson(this);

  static StoreEntity toEntity(RemoteStoreModel? model) {
    if (model == null) {
      return  StoreEntity(
        name: 'Fake Store',
        image: 'https://example.com/default-store.png',
        address: '123 Fake Street, Cairo, Egypt',
        phoneNumber: '0100000000',
        latLong:LatLng(30.0444,31.2357) ,
      );
    }

    return StoreEntity(
      name: model.name ?? 'Fake Store',
      image: model.image ?? 'https://example.com/default-store.png',
      address: model.address ?? '123 Fake Street, Cairo, Egypt',
      phoneNumber: model.phoneNumber ?? '0100000000',
      latLong: model.latLong ?? LatLng(.0444,31.2357),
    );
  }

  factory RemoteStoreModel.fromEntity(StoreEntity entity) {
    return RemoteStoreModel(
      name: entity.name,
      image: entity.image,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      latLong: entity.latLong,
    );
  }
}
