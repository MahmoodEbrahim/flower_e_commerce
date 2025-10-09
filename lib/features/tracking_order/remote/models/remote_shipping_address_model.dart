import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/shipping_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_shipping_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteShippingAddressModel {
@JsonKey(name: JsonSerlizableConstants.street)
String? street;

@JsonKey(name: JsonSerlizableConstants.city)
String? city;

@JsonKey(name: JsonSerlizableConstants.phone)
String? phone;

@JsonKey(name: JsonSerlizableConstants.lat)
double? lat;

@JsonKey(name: JsonSerlizableConstants.long)
double? long;


  RemoteShippingAddressModel({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory RemoteShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteShippingAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteShippingAddressModelToJson(this);


  static ShippingAddressEntity toEntity(
    RemoteShippingAddressModel? model,
  ) {
    if (model == null) {
      return ShippingAddressEntity(
        street: "Zagazig",
        city: "Sharkia",
        phone: "01010518802",
        lat: 31.7195459,
        long: 31.7195459,
      );
    }

    return ShippingAddressEntity(
      street: model.street ?? "",
      city: model.city ?? "",
      phone: model.phone ?? "",
      lat: model.lat ??31.7195459 ,
      long: model.long ?? 31.7195459,
    );
  }


  factory RemoteShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return RemoteShippingAddressModel(
      street: entity.street,
      city: entity.city,
      phone: entity.phone,
      lat: entity.lat,
      long: entity.long,
    );
  }
}
