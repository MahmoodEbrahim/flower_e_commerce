
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/core/utils/constants/api_parameters.dart';
import 'package:flower_e_commerce/features/home/api/models/products_by_occassion/product_by_occasion.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class HomeApiService {

  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

@GET(ApiEndPoints.productsByOccasionEndPoint)
  Future<ProductByOccasionDto> getProductsDetialsByOccasions(
    @Query(ApiParameters.productsByOccasionParameter)String occasionId
    );
}