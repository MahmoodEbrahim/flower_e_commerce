import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';

abstract interface class HomeRemoteDataSource {
  Future<ApiResult<List<ProductDetailsEntity>>>
  getProductsDetialsByOccasions(String occasionId);

}