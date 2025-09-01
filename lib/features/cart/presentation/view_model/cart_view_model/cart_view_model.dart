import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton

class CartViewModel extends Bloc<CartEvents, CartStates> {
  CartViewModel() : super(CartStates()) {
    on<AddProductsToCart>(_addProducts);
  }

  void _addProducts(AddProductsToCart event, Emitter emit) {
    emit(state.copyWith(isLoading: true));
    final productList = List.of(state.products);
    productList.add(event.product);
    print(productList);
    print(event.product);

    emit(state.copyWith(
        errorMessage: null, products: productList, isLoading: false));
  }
}
