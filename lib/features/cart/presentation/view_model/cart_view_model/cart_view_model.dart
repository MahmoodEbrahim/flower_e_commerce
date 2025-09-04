// import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
// import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';

// @singleton
// class CartViewModel extends Bloc<CartEvents, CartStates> {
//   CartViewModel() : super(CartStates()) {
//     on<AddProductsToCartEvent>(_addProducts);
//     on<DecreaseProductQuantityCartEvent>(_decreaseProductQuatity);
//     on<IncreaseProductQuantityCartEvent>(_increaseProductQuatity);
//     on<DeleteProductQuantityCartEvent>(_deleteProductQuantity);
//     on<CalculateTotalCartEvent>(_calculatePrice);
//   }

//   void _addProducts(AddProductsToCartEvent event, Emitter emit) {
//     emit(state.copyWith(isLoading: true));

//     final cartList = List.of(state.products);
//     final newProduct = event.product;
//     bool flag = false;
//     for (int i = 0; i < cartList.length; i++) {
//       if (cartList[i].productModel.id == newProduct.id) {
//         cartList[i].stock++;
//         flag = true;
//         break;
//       }
//     }
//     if (!flag) {
//       final CartEntity cartEntity = CartEntity(productModel: newProduct);
//       cartList.add(cartEntity);
//     }

//     emit(state.copyWith(
//         errorMessage: null, products: cartList, isLoading: false));

//     add(CalculateTotalCartEvent());
//   }

//   void _decreaseProductQuatity(
//       DecreaseProductQuantityCartEvent event, Emitter emit) {
//     final updatedList = state.products.map((product) {
//       if (product.productModel.id == event.cartEntity.productModel.id) {
//         final newQuantity = product.stock - 1;

//         return product.copyWith(stock: newQuantity < 0 ? 0 : newQuantity);
//       }
//       return product;
//     }).toList();

//     final filteredList =
//         updatedList.where((product) => product.stock > 0).toList();

//     emit(state.copyWith(
//         errorMessage: null, products: filteredList, isLoading: false));

//          add(CalculateTotalCartEvent());
//   }

//   void _increaseProductQuatity(
//       IncreaseProductQuantityCartEvent event, Emitter emit) {
//     final updatedList = state.products.map((product) {
//       if (product.productModel.id == event.cartEntity.productModel.id) {
//         final newQuantity = product.stock + 1;
//         return product.copyWith(stock: newQuantity);
//       }
//       return product;
//     }).toList();

//     emit(state.copyWith(
//         errorMessage: null, products: updatedList, isLoading: false));

//          add(CalculateTotalCartEvent());
//   }

//   void _deleteProductQuantity(
//       DeleteProductQuantityCartEvent event, Emitter emit) {
//     final updatedList = state.products
//         .where((product) =>
//             product.productModel.id != event.cartEntity.productModel.id)
//         .toList();

//     emit(state.copyWith(
//         isLoading: false, errorMessage: null, products: updatedList));
//          add(CalculateTotalCartEvent());
//   }

//   void _calculatePrice(CalculateTotalCartEvent event, Emitter emit) {
//     int subTotal = 0;
//     int? unitPrice = 0;

//     for (final product in state.products) {
//       unitPrice =
//           product.productModel.priceAfterDiscount ?? product.productModel.price;
//       subTotal += unitPrice! * product.stock;
//     }

//     const deliveryFee = 10;
//     final total = subTotal == 0 ? 0 : subTotal + deliveryFee;

//     emit(state.copyWith(
//       price: subTotal,
//       priceAfterFee: total,
//     ));
//   }
// }

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
