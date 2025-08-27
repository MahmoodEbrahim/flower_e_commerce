import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';


import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final HomeApiService _homeApiService;

  HomeRemoteDataSourceImp(this._homeApiService);

  @override
  Future<ApiResult<List<ProductsEntity>>> getProductsByCategoryId(
      String catId) async {
    try {
      final productsDtoList =
          await _homeApiService.getProductsByCategoryId(catId);

      final productModelList = productsDtoList.products!
          .map((dto) => dto.toEntity())
          .toList();

      return ApiSucessResult(productModelList);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }
}
