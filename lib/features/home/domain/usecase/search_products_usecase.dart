import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchProductsUseCase {
  final HomeRepository _homeRepository;
  SearchProductsUseCase(this._homeRepository);

  Future<Result<List<ProductsEntity>>> call(
    String keyword, {
    CancelToken? cancelToken,
  }) async {
    return await _homeRepository.searchProducts(
      keyword.trim(),
      cancelToken: cancelToken,
    );
  }
}
