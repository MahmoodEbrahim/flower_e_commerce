import 'package:dio/src/cancel_token.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

abstract interface class HomeRemoteDataSource {
  Future<ApiResult<List<ProductsEntity>>>
  getProductsDetialsByOccasions(String occasionId);

  Future<ApiResult<HomeEntity>> getHomeData();
  Future<ApiResult<List<ProductsEntity>>> getProductsByCategoryId(String catId);
  Future<ApiResult<List<ProductsEntity>>> searchProducts(String keyword,
      {CancelToken? cancelToken});
  Future<ApiResult<List<ProductsEntity>>> getSearchProducts(
    String filter,
    String? catId,
  );
}