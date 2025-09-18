import 'package:dio/dio.dart';
import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';
class TokenInterceptor extends Interceptor {
  UserLocalStorage userLocalStorage;
  TokenInterceptor(this.userLocalStorage);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await userLocalStorage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        print('🔑 [TokenInterceptor] Added token to headers: $token');
      } else {
        print('⚠️ [TokenInterceptor] No token found');
      }
    } catch (e) {
      print('❌ Failed to get token: $e');
    }
    super.onRequest(options, handler);
  }
}
