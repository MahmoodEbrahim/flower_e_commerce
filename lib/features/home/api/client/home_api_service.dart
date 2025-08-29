import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/core/utils/constants/api_parameters.dart';
import 'package:flower_e_commerce/features/home/api/models/category_products_response_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/home_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_by_occasion.dart';


import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class HomeApiService {
  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(ApiEndPoints.productsEndPoint)
  Future<CategoryProductsResponseDto> getProductsByCategoryId(
    @Query("category") String categoryId,
  );
  @GET(ApiEndPoints.productsByOccasionEndPoint)
  Future<ProductByOccasionDto> getProductsDetialsByOccasions(
      @Query(ApiParameters.productsByOccasionParameter)String occasionId
      );

  @GET('home')
  Future<HomeModel> getHomeData();
}
