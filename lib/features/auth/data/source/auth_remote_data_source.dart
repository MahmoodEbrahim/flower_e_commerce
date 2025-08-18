import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<LoginEntity>> login(String email, String password);
}
