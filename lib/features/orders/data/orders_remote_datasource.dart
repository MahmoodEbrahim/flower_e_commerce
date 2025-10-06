import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';

abstract interface class OrdersRemoteDataSource {
  Future<Result<OrdersResponceEntity>> GetOrders();
}
