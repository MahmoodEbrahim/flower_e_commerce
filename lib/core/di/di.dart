import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;
Dio getDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPoints.apiUrl,
      headers: {
        'content-type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('Request: ${options.method} ${options.uri}, Headers: ${options.headers}, Data: ${options.data}');
      return handler.next(options);
    },
    onError: (e, handler) {
      print('Error: ${e.message}, Response: ${e.response?.data}');
      return handler.next(e);
    },
  ));
  return dio;
}
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
}