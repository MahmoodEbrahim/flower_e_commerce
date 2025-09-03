// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartOfUserUseCase {
  final CartRepository _cartRepository;
  GetCartOfUserUseCase(
    this._cartRepository,
  );

  Future<ApiResult<CartResponseEntity>> getCartOfUser() async {
    return await _cartRepository.getCartOfUser();
  }
}
