import 'package:dio/dio.dart' hide Headers;
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart' hide Headers;

import '../models/cash_order_responce_model.dart';
import '../models/online_payment_responce_model.dart';
part 'payment_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class PaymentApiService {
  @factoryMethod
  factory PaymentApiService(Dio dio) = _PaymentApiService;
@POST(ApiEndPoints.createcashorder)
// @Headers(<String, dynamic>{
//   'Authorization':"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhjMWEwNjhhOGJjYTMwN2Y5ZTMyMzA5Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTc1NDMwODB9.h2gpZGY2QesvZkREXTWS7duoobPJuNDR7MXne9e745A"
// }
//)
  Future<CashOrderResponce>
createCashOrder(@Body() CashOrderRequest request,
     // @Header("Authorization")String token);

      );
@POST(ApiEndPoints.createcardorder)



  Future<OnlinePaymentResponce>
createOnlineOrder(@Body() CashOrderRequest orderData);
}
/*<String, dynamic>{
  "shippingAddress":{
    "street": "details",
    "phone": "01010800921",
    "city": "Cairo",
    "lat": "String",
    "long": "String"
  }
}*/