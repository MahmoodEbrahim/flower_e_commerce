import 'package:json_annotation/json_annotation.dart';

import 'cart_model.dart';
import 'online_payment_responce_model.dart';
part 'payment_method_options_model.g.dart';

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: "card")
  final Card? card;

  PaymentMethodOptions ({
    this.card,
  });

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodOptionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentMethodOptionsToJson(this);
  }
}
