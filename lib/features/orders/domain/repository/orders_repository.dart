import '../../../../core/api_result/api_result.dart';
import '../entity/order_entity/orders_responce_entity.dart';

abstract interface class OrdersRepository {
  Future<ApiResult<OrdersResponceEntity>> GetOrders();
}