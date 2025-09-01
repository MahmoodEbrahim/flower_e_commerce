// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';


class CartStates {
  String? errorMessage;
  bool isLoading;
  List<CartEntity> products;
  int? price;
  int? priceAfterFee;
  CartStates({
    this.errorMessage,
    this.isLoading = true,
    this.products = const [],
    this.price=0,
    this.priceAfterFee=0,
  });

  CartStates copyWith({
    String? errorMessage,
    bool? isLoading,
    List<CartEntity>? products,
     int? price,
  int? priceAfterFee
  }) {
    return CartStates(
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      price: price,
      priceAfterFee: priceAfterFee
    );
  }
}
