import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';


class OrdersResponceEntity extends Equatable {
  final String? message;
  final MetaDataDto? metadata;
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