import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/data/orders_remote_datasource.dart';
import 'package:flower_e_commerce/features/orders/domain/repository/orders_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/order_entity/orders_responce_entity.dart';

@Injectable(as: OrdersRepository)
class OrdersRepoImpl implements OrdersRepository {
  OrdersRemoteDataSource ordersRemoteDataSource;
  @factoryMethod
  OrdersRepoImpl({required this.ordersRemoteDataSource});

  @override
  Future<Result<OrdersResponceEntity>> GetOrders() {
    return ordersRemoteDataSource.GetOrders();
  }
}
