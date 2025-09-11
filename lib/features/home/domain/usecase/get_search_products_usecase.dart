// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetSearchProductsUsecase {
  final HomeRepository _homeRepository;
  GetSearchProductsUsecase(this._homeRepository);

  Future<ApiResult<List<ProductsEntity>>> getSearchProducts(
    String filter,
    String? catId,
  ) async {
    return await _homeRepository.getSearchProducts(filter, catId);
  }
}
