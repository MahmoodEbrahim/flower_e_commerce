import 'package:dio/dio.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final LoginModel? user = UserLocalStorage.getUser();

    if (user != null && user.token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${user.token}';
    }

    super.onRequest(options, handler);
  }
}
