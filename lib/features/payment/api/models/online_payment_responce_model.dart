import 'package:flower_e_commerce/features/payment/api/models/payment_method_config_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/payment_method_options_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/phone_number_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/session_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/total_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'adaptive_pricing_model.dart';
import 'automatic_tax_model.dart';
import 'cart_model.dart';
import 'collected_info_model.dart';
import 'custom_text_model.dart';
import 'customer_details_model.dart';
import 'invoice_creation_model.dart';
import 'invoice_data_model.dart';
import 'meta_data_payment.dart';

part 'online_payment_responce_model.g.dart';

@JsonSerializable()
class OnlinePaymentResponce {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "session")
  final Session? session;

  OnlinePaymentResponce ({
    this.message,
    this.session,
  });

  factory OnlinePaymentResponce.fromJson(Map<String, dynamic> json) {
    return _$OnlinePaymentResponceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OnlinePaymentResponceToJson(this);
  }
}























