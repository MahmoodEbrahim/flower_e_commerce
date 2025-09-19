import 'package:dio/dio.dart' hide Headers;
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'checkout_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class CheckoutApiService {
  @factoryMethod
  factory CheckoutApiService(Dio dio) = _CheckoutApiService;
}