import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
Dio provideDio() {
  final dio = Dio();
  dio.interceptors.add(getIt.get<PrettyDioLogger>());
  return dio;
}



  @lazySingleton
  PrettyDioLogger prettyDioLoggerProvider() {
    return PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    );
  }

}