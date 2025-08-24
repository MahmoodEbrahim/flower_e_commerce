
import 'package:injectable/injectable.dart';
import '../../data/models/homemodel.dart';
import '../repository/home_repository.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Homemodel> call() async {
    return await repository.getHomeData();
  }
}