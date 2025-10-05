import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'tracking_api_service.g.dart';

@RestApi(baseUrl:"")
@injectable
abstract class TrackingApiService {
  @factoryMethod
  factory TrackingApiService(Dio dio) = _TrackingApiService;

  
}



