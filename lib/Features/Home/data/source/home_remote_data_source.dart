import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<HomeEntity>> getHomeData();
}