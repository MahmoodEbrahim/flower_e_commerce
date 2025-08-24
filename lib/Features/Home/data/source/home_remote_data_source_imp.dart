import 'package:injectable/injectable.dart';
import '../models/homemodel.dart';
import 'home_api_service.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final HomeApiService apiService;

  HomeRemoteDataSourceImp(this.apiService);

  @override
  Future<Homemodel> getHomeData() async {
    return await apiService.getHomeData();
  }
}