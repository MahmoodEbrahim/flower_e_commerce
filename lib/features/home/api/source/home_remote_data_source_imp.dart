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
  Future<Result<List<ProductsEntity>>> getProductsDetialsByOccasions(
    String occasionId,
  ) async {
    try {
      final response = await _apiService.getProductsDetialsByOccasions(
        occasionId,
      );

      final products =
          response.products?.map((e) => e.toEntity()).toList() ?? [];
      if (response.products == null) {
        return FailedResult('Products list is null');
      } else {
        return SucessResult(products);
      }
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }

  @override
  Future<Result<List<ProductsEntity>>> getProductsByCategoryId(
    String catId,
  ) async {
    try {
      final productsDtoList = await _apiService.getProductsByCategoryId(catId);

      final productModelList = productsDtoList.products!
          .map((dto) => dto.toEntity())
          .toList();

      return SucessResult(productModelList);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return FailedResult(errorMessage);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }

  @override
  Future<Result<List<ProductsEntity>>> getSearchProducts(
    String filter,
    String? catId,
  ) async {
    try {
      final searchResponse = await _apiService.getSearchProducts(filter, catId);
      final products = searchResponse.products!.map((model) {
        return model.toEntity();
      }).toList();
      return SucessResult(products);
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      return FailedResult(errorMessage);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }

  @override
  Future<Result<HomeEntity>> getHomeData() async {
    try {
      final homeModel = await _apiService.getHomeData();

      return SucessResult(homeModel.toEntity());
    } catch (e) {
      return FailedResult('Failed to fetch home data: $e');
    }
  }

  @override
  Future<Result<List<ProductsEntity>>> searchProducts(
    String keyword, {
    CancelToken? cancelToken,
  }) async {
    try {
      final productsDtoList = await _apiService.searchProducts(
        keyword,
        cancelToken: cancelToken,
      );

      final productsEntityList = productsDtoList.products!
          .map((dto) => dto.toEntity())
          .toList();

      return SucessResult(productsEntityList);
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }
}
