import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';

abstract interface class CartRepository {
  Future<Result<CartResponseEntity>> addProductToCart(
    CartItemRequestEntity cartRequestModel,
  );
  Future<Result<CartResponseEntity>> getCartOfUser();

  Future<Result<CartResponseEntity>> deleteItemFromCart(String itemId);
  Future<Result<CartResponseEntity>> updateQuantity(
    UpdatedQuatityRequestEntity updatedReq,
  );
}
