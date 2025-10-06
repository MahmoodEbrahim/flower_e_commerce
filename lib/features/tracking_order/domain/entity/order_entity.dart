

import 'package:flower_e_commerce/features/tracking_order/domain/entity/order_info_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/order_item_entity.dart' show OrderItemEntity;
import 'package:flower_e_commerce/features/tracking_order/domain/entity/payment_info_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/shipping_address_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/store_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/user_entity.dart';

class OrderEntity {
  final String id;
  final UserEntity user;
  final List<OrderItemEntity> orderItems;
  final ShippingAddressEntity shippingAddress;
  final StoreEntity store;
  final PaymentInfoEntity paymentInfoEntity;
  final OrderInfoEntity orderInfoEntity;

  OrderEntity({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.shippingAddress,
    required this.store,
    required this.paymentInfoEntity,
    required this.orderInfoEntity
  });

  OrderEntity copyWith({
    String? id,
    UserEntity? user,
    List<OrderItemEntity>? orderItems,
    ShippingAddressEntity? shippingAddress,
    StoreEntity? store,
    PaymentInfoEntity? paymentInfoEntity,
    OrderInfoEntity? orderInfoEntity
  }) {
    return OrderEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      orderItems: orderItems ?? this.orderItems,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      store: store ?? this.store,
      paymentInfoEntity: paymentInfoEntity ?? this.paymentInfoEntity,
      orderInfoEntity: orderInfoEntity??this.orderInfoEntity
    );
  }
}
