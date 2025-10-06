import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductDetialsByOccasionUseCase {
  final HomeRepository _homeRepository;
  GetProductDetialsByOccasionUseCase(this._homeRepository);
  Future<Result<List<ProductsEntity>>> getProductsDetialsByOccasions(
    String occasionId,
  ) async {
    return await _homeRepository.getProductsDetialsByOccasions(occasionId);
  }
}
