import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';

abstract interface class CartRemoteDataSouce {
  Future<ApiResult<CartResponseEntity>> addProductToCart(
      CartItemRequestEntity cartRequestModel);


      Future<ApiResult<CartResponseEntity>> getCartOfUser();


      
    Future<ApiResult<CartResponseEntity>> deleteItemFromCart(
      String itemId);


       Future<ApiResult<CartResponseEntity>> updateQuantity(
      UpdatedQuatityRequestEntity updatedReq);
}
