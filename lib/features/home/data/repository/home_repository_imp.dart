import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';


import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImp(this._homeRemoteDataSource);
  @override
  Future<ApiResult<List<ProductsEntity>>> getProductsDetialsByOccasions
      (String occasionId) async{

return _homeRemoteDataSource.getProductsDetialsByOccasions(occasionId);
  }

  @override
  Future<ApiResult<List<ProductsEntity>>> getProductsByCategoryId(
      String catId) async {
    return await _homeRemoteDataSource.getProductsByCategoryId(catId);
  }

  @override
  Future<ApiResult<HomeEntity>> getHomeData() async {
    try {
      return await _homeRemoteDataSource.getHomeData();
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }

  @override
  Future<ApiResult<List<ProductsEntity>>> searchProducts(String keyword) async{
    return await _homeRemoteDataSource.searchProducts(keyword);
  }
}