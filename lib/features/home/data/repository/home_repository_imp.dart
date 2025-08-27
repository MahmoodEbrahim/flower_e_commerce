import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:HomeRepository )
class HomeRepositoryImp implements HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp(this.homeRemoteDataSource);
  @override
  Future<ApiResult<List<ProductDetailsEntity>>> getProductsDetialsByOccasions(String occasionId) async{
    // TODO: implement getProductsDetialsByOccasions
    return await homeRemoteDataSource.getProductsDetialsByOccasions(occasionId);
  }
}