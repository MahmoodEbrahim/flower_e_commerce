import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/api/client/cart_api_service.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_item_request_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/updated_request_body_model.dart';
import 'package:flower_e_commerce/features/cart/data/source/cart_remote_data_souce.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSouce)
class CartRemoteDataSouceImp implements CartRemoteDataSouce {
  final CartApiService _cartApiService;
  CartRemoteDataSouceImp(this._cartApiService);
  @override
  Future<ApiResult<CartResponseEntity>> addProductToCart(
      CartItemRequestEntity cartRequestModel) async {
    try {
      final cartResponseModel = await _cartApiService
          .addProductToCart(CartItemRequestModel.toModel(cartRequestModel));
      final cartResponseEntity = cartResponseModel.toEntity();
      return ApiSucessResult(cartResponseEntity);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }

  @override
  Future<ApiResult<CartResponseEntity>> getCartOfUser() async {
    try {
      final cartResponseModel = await _cartApiService.getCartUser();
      final cartResponseEntity = cartResponseModel.toEntity();
      return ApiSucessResult(cartResponseEntity);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }

  @override
  Future<ApiResult<CartResponseEntity>> deleteItemFromCart(
      String itemId) async {
    try {
      final cartResponseModel =
          await _cartApiService.deleteItemFromCart(itemId);
      final cartResponseEntity = cartResponseModel.toEntity();
      return ApiSucessResult(cartResponseEntity);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }

  @override
  Future<ApiResult<CartResponseEntity>> updateQuantity(
      UpdatedQuatityRequestEntity updatedReq) async {
    try {
      final cartResponseModel =
          await _cartApiService.updateQuantity(updatedReq.itemId,UpdatedRequestBodyModel.toModel(updatedReq.updatedRequestBody) );
      final cartResponseEntity = cartResponseModel.toEntity();
      return ApiSucessResult(cartResponseEntity);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }


}
