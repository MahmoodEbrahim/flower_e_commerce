import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../../../cart/domain/entity/cart_response_entity.dart';
import '../repository/orders_repository.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepository _ordersRepository;
  GetOrdersUseCase(
      this._ordersRepository,
      );

  Future<ApiResult<OrdersResponceEntity>> GetOrders() async {
    return await _ordersRepository.GetOrders();
  }
}
