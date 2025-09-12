import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';

import '../../../../home/api/models/product_by_occasion.dart';


class OrdersResponceEntity extends Equatable {
  final String? message;
  final Metadata? metadata;
  final List<OrdersEntity>? orders;
  const OrdersResponceEntity({
    this.message,
    this.metadata,
    this.orders,
  });

  @override
  List<Object?> get props => [
    message,
    metadata,
    orders,
  ];
}