
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class HomeApiService {
  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET('home')
  Future<Homemodel> getHomeData();
}