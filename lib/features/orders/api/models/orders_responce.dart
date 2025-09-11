import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/api/models/product_by_occasion.dart';
import '../../domain/entity/order_entity/orders_responce_entity.dart';
import 'orders_model.dart';

part 'orders_responce.g.dart';

@JsonSerializable()
class OrdersResponce {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "orders")
  final List<Orders>? orders;

  OrdersResponce ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory OrdersResponce.fromJson(Map<String, dynamic> json) {
    return _$OrdersResponceFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersResponceToJson(this);
  }
  OrdersResponceEntity toEntity() => OrdersResponceEntity(
        message: message,
        metadata: metadata,
        orders: orders?.map((e) => e.toEntity()).toList(),
      );
}







