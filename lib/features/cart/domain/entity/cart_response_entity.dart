import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';

class CartResponseEntity extends Equatable {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const CartResponseEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  CartResponseEntity copyWith({
    String? message,
    int? numOfCartItems,
    CartEntity? cart,
  }) {
    return CartResponseEntity(
      message: message ?? this.message,
      numOfCartItems: numOfCartItems ?? this.numOfCartItems,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}
