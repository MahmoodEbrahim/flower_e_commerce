import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

abstract interface class AuthRepository {
  Future<ApiResult<LoginModel>> login(String email,String password);
  
}