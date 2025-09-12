import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_items_model.dart';
import 'orders_responce.dart';
part 'orders_model.g.dart';


@JsonSerializable()
class Orders {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<OrderItems>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;


  Orders ({
    this.Id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,

  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return _$OrdersFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersToJson(this);
  }
  OrdersEntity toEntity() => OrdersEntity(
        Id: Id,
        user: user,
        orderItems: orderItems?.map((e) => e.toEntity()).toList(),
        totalPrice: totalPrice,
        paymentType: paymentType,
        isPaid: isPaid,
        isDelivered: isDelivered,
        state: state,
        createdAt: createdAt,
        updatedAt: updatedAt,
        orderNumber: orderNumber,
      );
}