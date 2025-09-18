import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/network/token_interceptor.dart';
import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(TokenInterceptor tokenInterceptor, PrettyDioLogger logger) {
    final dio = Dio();
    dio.interceptors.add(logger);
    dio.interceptors.add(tokenInterceptor);
    return dio;
  }

  @lazySingleton
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  );

  @lazySingleton
  TokenInterceptor tokenInterceptor(UserLocalStorage storage) =>
      TokenInterceptor(storage);
}
