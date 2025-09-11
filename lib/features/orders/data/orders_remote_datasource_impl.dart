import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/api/client/orders_api_service.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:injectable/injectable.dart';

import 'orders_remote_datasource.dart';
@Injectable(as:OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  OrdersApiService ordersApiService;
@factoryMethod
  OrdersRemoteDataSourceImpl({required this.ordersApiService});

  @override
  Future<ApiResult<OrdersResponceEntity>> GetOrders() async {
    try {
      var response = await ordersApiService.getOrders();
      var entity = response.toEntity();
      return ApiSucessResult(entity);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }
}
