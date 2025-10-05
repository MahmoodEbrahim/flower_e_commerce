import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';

class CartStates extends Equatable {
  final String? errorMessage;
  final bool isLoading;
  final CartResponseEntity? cartResonse;

  const CartStates({
    this.errorMessage,
    this.isLoading = true,
    this.cartResonse,
  });

  CartStates copyWith({
    String? errorMessage,
    bool? isLoading,
    CartResponseEntity? cart,
  }) {
    return CartStates(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      cartResonse: cart ?? cartResonse,
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, cartResonse];
}
