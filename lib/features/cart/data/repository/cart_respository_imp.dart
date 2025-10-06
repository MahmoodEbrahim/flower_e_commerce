// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:flower_e_commerce/features/cart/data/source/cart_remote_data_souce.dart';
import 'package:flower_e_commerce/features/cart/domain/repository/cart_repository.dart';

@Injectable(as: CartRepository)
class CartRespositoryImp implements CartRepository {
  final CartRemoteDataSouce _cartRemoteDataSouce;
  CartRespositoryImp(this._cartRemoteDataSouce);

  @override
  Future<Result<CartResponseEntity>> addProductToCart(
    CartItemRequestEntity cartRequestModel,
  ) async {
    return await _cartRemoteDataSouce.addProductToCart(cartRequestModel);
  }

  @override
  Future<Result<CartResponseEntity>> getCartOfUser() async {
    return await _cartRemoteDataSouce.getCartOfUser();
  }

  @override
  Future<Result<CartResponseEntity>> deleteItemFromCart(String itemId) async {
    return await _cartRemoteDataSouce.deleteItemFromCart(itemId);
  }

  @override
  Future<Result<CartResponseEntity>> updateQuantity(
    UpdatedQuatityRequestEntity updatedReq,
  ) async {
    return await _cartRemoteDataSouce.updateQuantity(updatedReq);
  }
}
