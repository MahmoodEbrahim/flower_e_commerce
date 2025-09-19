import 'package:json_annotation/json_annotation.dart';

part 'cash_order_request.g.dart';

@JsonSerializable()
class CashOrderRequest {
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;

  CashOrderRequest ({
    this.shippingAddress,
  });

  factory CashOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$CashOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CashOrderRequestToJson(this);
  }
}

@JsonSerializable()
class ShippingAddress {
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

  ShippingAddress ({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return _$ShippingAddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShippingAddressToJson(this);
  }
}


