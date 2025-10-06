import 'package:dio/src/cancel_token.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<List<ProductsEntity>>> getProductsDetialsByOccasions(
    String occasionId,
  );

  Future<Result<HomeEntity>> getHomeData();
  Future<Result<List<ProductsEntity>>> getProductsByCategoryId(String catId);
  Future<Result<List<ProductsEntity>>> searchProducts(
    String keyword, {
    CancelToken? cancelToken,
  });
  Future<Result<List<ProductsEntity>>> getSearchProducts(
    String filter,
    String? catId,
  );
}
