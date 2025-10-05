import 'package:flower_e_commerce/features/payment/api/models/session_model.dart';
import 'package:json_annotation/json_annotation.dart';


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























