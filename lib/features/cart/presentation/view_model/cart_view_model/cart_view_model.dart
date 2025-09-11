import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/delete_item_from_cart.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/get_cart_of_user.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/update_quatity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class CartViewModel extends Bloc<CartEvents, CartStates> {
  final AddToCartUsecase _addToCartUsecase;
  final GetCartOfUserUseCase _getCartOfUser;
  final DeleteItemFromCartUseCase _deleteItemFromCartUseCase;
  final UpdateQuatityUseCase _updateQuatityUseCase;

  CartViewModel(this._addToCartUsecase, this._getCartOfUser,
      this._deleteItemFromCartUseCase,this._updateQuatityUseCase)
      : super(CartStates()) {
    on<AddToCartEvent>(_addToCart);
    on<GetCartItemsEvent>(_getCartItems);
    on<DeleteItemFromCartEvent>(_deleteItemFromCart);
    on<UpdateQuatityItemCEvent>(_updateQuanity);
    on<ClearCartErrorEvent>((event, emit) {
      emit(state.copyWith(errorMessage: null));
    });

  }

  Future<void> _addToCart(AddToCartEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final res =
    await _addToCartUsecase.addProductToCart(event.cartItemRequestEntity);

    switch (res) {
      case ApiSucessResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: null, cart: res.sucessResult));
      case ApiFailedResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: res.errorMessage, cart: state.cartResonse));
    }
  }

  Future<void> _getCartItems(GetCartItemsEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final res = await _getCartOfUser.getCartOfUser();

    switch (res) {
      case ApiSucessResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: null, cart: res.sucessResult));
      case ApiFailedResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: res.errorMessage, cart: state.cartResonse));
    }
  }

  Future<void> _deleteItemFromCart(
      DeleteItemFromCartEvent event, Emitter emit) async {

    final res =
    await _deleteItemFromCartUseCase.deleteItemFromCart(event.itemId);

    switch (res) {
      case ApiSucessResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: null, cart: res.sucessResult));
      case ApiFailedResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: res.errorMessage, cart: state.cartResonse));
    }
  }
  Future<void> _updateQuanity(
      UpdateQuatityItemCEvent event, Emitter emit) async {

    final res =
    await _updateQuatityUseCase.updateQuantity(event.updatedReq);

    switch (res) {
      case ApiSucessResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: null, cart: res.sucessResult));
      case ApiFailedResult<CartResponseEntity>():
        emit(state.copyWith(
            isLoading: false, errorMessage: res.errorMessage, cart: state.cartResonse));
    }
  }
}
