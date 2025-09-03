import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item.dart';

class CartEntity extends Equatable {
  final String? user;
  final List<CartItemEntity>? cartItems;
  final String? id;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;

  const CartEntity({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,
  });

  CartEntity copyWith({
    String? user,
    List<CartItemEntity>? cartItems,
    String? id,
    List<dynamic>? appliedCoupons,
    int? totalPrice,
  }) {
    return CartEntity(
      user: user ?? this.user,
      cartItems: cartItems ?? this.cartItems,
      id: id ?? this.id,
      appliedCoupons: appliedCoupons ?? this.appliedCoupons,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [user, cartItems, id, appliedCoupons, totalPrice];
}
