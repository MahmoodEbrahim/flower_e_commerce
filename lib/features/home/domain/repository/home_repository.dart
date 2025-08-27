import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';



abstract interface class HomeRepository {
  Future<ApiResult<List<ProductModel>>> getProductsByCategoryId(String catId);
}
