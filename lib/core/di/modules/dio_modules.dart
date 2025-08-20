import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(PrettyDioLogger logger) {
    final dio = Dio();
    dio.interceptors.add(logger);
    return dio;
  }

  @lazySingleton
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  );
}
