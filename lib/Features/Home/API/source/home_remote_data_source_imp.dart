import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/source/home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService homeApiService;

  HomeRemoteDataSourceImpl(this.homeApiService);

  @override
  Future<ApiResult<HomeEntity>> getHomeData() async {
    try {
      final homeModel = await homeApiService.getHomeData();
      return ApiSucessResult(homeModel.toEntity());
    } catch (e) {
      return ApiErrorResult('Failed to fetch home data: $e');
    }
  }
}
