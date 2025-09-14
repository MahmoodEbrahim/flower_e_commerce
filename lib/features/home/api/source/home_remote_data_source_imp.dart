import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final HomeApiService _apiService;
  HomeRemoteDataSourceImp(this._apiService);
  @override
  Future<ApiResult<List<ProductsEntity>>> getProductsDetialsByOccasions(
    String occasionId,
  ) async {
    try {
      final response = await _apiService.getProductsDetialsByOccasions(
        occasionId,
      );
      final products =
          response.products?.map((e) => e.toEntity()).toList() ?? [];
      if (response.products == null) {
        return ApiFailedResult('Products list is null');
      } else {
        return ApiSucessResult(products);
      }
    } catch (error) {
      if (error is DioException) {
        return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return ApiFailedResult(error.toString());
      }
    }
  }

  @override
  Future<ApiResult<List<ProductsEntity>>> getProductsByCategoryId(
    String catId,
  ) async {
    try {
      final productsDtoList = await _apiService.getProductsByCategoryId(catId);

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

  @override
  Future<ApiResult<HomeEntity>> getHomeData() async {
    try {
      final homeModel = await _apiService.getHomeData();
      return ApiSucessResult(homeModel.toEntity());
    } catch (e) {
      return ApiFailedResult('Failed to fetch home data: $e');
    }
  }

  @override
  Future<ApiResult<List<ProductsEntity>>> searchProducts(
      String keyword,
      {CancelToken? cancelToken}
      ) async {
    try {
      final productsDtoList = await _apiService.searchProducts(keyword,cancelToken:cancelToken );

      final productsEntityList = productsDtoList.products!
          .map((dto) => dto.toEntity())
          .toList();

      return ApiSucessResult(productsEntityList);
    } catch (error) {
      if (error is DioException) {
        return ApiFailedResult(
          ServerFailure.fromDioError(error).errorMessage,
        );
      } else {
        return ApiFailedResult(error.toString());
      }
    }
  }

}
