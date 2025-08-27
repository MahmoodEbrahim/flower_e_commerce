import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

abstract interface class HomeRepository {
  Future<ApiResult<List<ProductsEntity>>> getProductsByCategoryId(String catId);
}
