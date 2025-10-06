// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryIdUseCase {
  final HomeRepository _homeRepository;
  GetProductsByCategoryIdUseCase(this._homeRepository);

  Future<Result<List<ProductsEntity>>> getProductsByCategoryId(
    String catId,
  ) async {
    return await _homeRepository.getProductsByCategoryId(catId);
  }
}
