import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_item_request_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_response_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/updated_request_body_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class CartApiService {
  @factoryMethod
  factory CartApiService(Dio dio) = _CartApiService;


  @POST(ApiEndPoints.cartEndPoint)
  Future<CartResponseDto> addProductToCart(
      @Body() CartItemRequestModel cartRequestModel,
      );

  @GET(ApiEndPoints.cartEndPoint)
  Future<CartResponseDto> getCartUser();

  @DELETE("${ApiEndPoints.cartEndPoint}/{id}")
  Future<CartResponseDto> deleteItemFromCart(@Path("id") String itemId);

  @PUT("${ApiEndPoints.cartEndPoint}/{id}")
  Future<CartResponseDto> updateQuantity(
      @Path("id") String itemId,
      @Body() UpdatedRequestBodyModel quantity,
      );
}
