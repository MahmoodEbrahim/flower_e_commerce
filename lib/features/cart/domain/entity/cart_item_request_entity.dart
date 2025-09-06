import 'package:equatable/equatable.dart';

class CartItemRequestEntity extends Equatable {
  final String? product;
  final int? quantity;

  const CartItemRequestEntity({
    this.product,
    this.quantity,
  });

  @override
  List<Object?> get props => [product, quantity];
}
