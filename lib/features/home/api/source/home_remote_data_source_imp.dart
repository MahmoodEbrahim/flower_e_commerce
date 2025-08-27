import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:HomeRemoteDataSource )
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
HomeApiService _apiService;
HomeRemoteDataSourceImp(this._apiService);
  @override
  Future<ApiResult<List<ProductDetailsEntity>>>
  getProductsDetialsByOccasions(String occasionId) async{
    try{
      final response=await _apiService.getProductsDetialsByOccasions(occasionId);
final products=response.products!.map((e)=>e.toEntity()).toList()??[];
      if (response.products == null) {
        return ApiFailedResult( 'Products list is null');
      }else{
        return ApiSucessResult(products);
      }

    }catch(error){
if(error is DioException){
  return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
}else{
  return ApiFailedResult(error.toString());
}
    }
  }

}