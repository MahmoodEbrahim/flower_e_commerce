import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';

import '../../API/home_api_service.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService homeApiService;

  HomeRemoteDataSourceImpl(this.homeApiService);

  @override
  Future<HomeEntity> getHomeData() async {
    try {
      final homeModel = await homeApiService.getHomeData();
      return homeModel.toEntity();
    } catch (e) {
      throw Exception('Failed to fetch home data: $e');
    }
  }
}