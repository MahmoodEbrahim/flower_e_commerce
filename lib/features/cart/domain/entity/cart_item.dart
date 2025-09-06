import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductsEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const CartItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  CartItemEntity copyWith({
    ProductsEntity? product,
    int? price,
    int? quantity,
    String? id,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [product, price, quantity, id];
}
