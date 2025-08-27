import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetProductDetialsByOccasionUseCase{
  HomeRepository _homeRepository;
  GetProductDetialsByOccasionUseCase(this._homeRepository);
  Future<ApiResult<List<ProductDetailsEntity>>>
  getProductsDetialsByOccasions(String occasionId)async{
    return await _homeRepository.getProductsDetialsByOccasions(occasionId);
  }
}