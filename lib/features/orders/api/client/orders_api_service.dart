
import 'package:flower_e_commerce/features/orders/api/models/orders_responce.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/constants/api_end_points.dart' ;
import 'package:dio/dio.dart' hide Headers;
part 'orders_api_service.g.dart';



@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class OrdersApiService {
  @factoryMethod
  factory OrdersApiService(Dio dio) = _OrdersApiService;
  @GET(ApiEndPoints.ordersEndPoint)
  @Headers( <String, dynamic>{
   'Authorization':"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhjMWEwNjhhOGJjYTMwN2Y5ZTMyMzA5Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTc1NDMwODB9.h2gpZGY2QesvZkREXTWS7duoobPJuNDR7MXne9e745A"
  })
  Future<OrdersResponce> getOrders();

}

