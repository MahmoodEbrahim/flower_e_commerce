import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';
import '../repository/home_repository.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<ApiResult<HomeEntity>> call() async {
    return await repository.getHomeData();
  }
}