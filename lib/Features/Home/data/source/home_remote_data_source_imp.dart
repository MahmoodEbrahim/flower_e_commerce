import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/API/home_api_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:HomeRemoteDataSource)
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final HomeApiService apiService;

  HomeRemoteDataSourceImp(this.apiService);

  @override
  Future<Homemodel> getHomeData() async {
    return await apiService.getHomeData();
  }
}