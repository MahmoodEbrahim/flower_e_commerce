import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/order_items_entity.dart';


class OrdersEntity extends Equatable {
  final String? Id;
  final String? user;
  final List<OrderItemsEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;

  const OrdersEntity({
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

  @override
  List<Object?> get props => [
    Id,
    user,
    orderItems,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    createdAt,
    updatedAt,
    orderNumber,
  ];
}