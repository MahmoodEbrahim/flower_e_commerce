import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';


class OrderItemsEntity extends Equatable {
  final ProductsEntity? product;
  final int? price;
  final int? quantity;
  final String? Id;

  const OrderItemsEntity({
    this.product,
    this.price,
    this.quantity,
    this.Id,
  });

  @override
  List<Object?> get props => [
    product,
    price,
    quantity,
    Id,
  ];
}