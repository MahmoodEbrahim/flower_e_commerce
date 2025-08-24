
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/homemodel.dart';
import '../repository/home_repository.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<dynamic, Homemodel>> call() {
    return repository.getHomeData();
  }
}