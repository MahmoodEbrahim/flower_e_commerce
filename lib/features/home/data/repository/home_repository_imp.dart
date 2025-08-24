import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Homemodel> getHomeData() async {
    try {
      final response = await remoteDataSource.getHomeData();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}