import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/home_repository.dart';
import '../models/homemodel.dart';
import '../source/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<dynamic, Homemodel>> getHomeData() async {
    try {
      final response = await remoteDataSource.getHomeData();
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(e);
      }
      return Left(e.toString());
    }
  }
}