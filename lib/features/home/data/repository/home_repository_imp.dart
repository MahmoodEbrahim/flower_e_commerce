import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<HomeEntity>> getHomeData() async {
    try {
      return await remoteDataSource.getHomeData();
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }
}
