
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/home_model.dart';
import '../repository/home_repository.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<HomeEntity> call() async {
    return await repository.getHomeData();
  }
}