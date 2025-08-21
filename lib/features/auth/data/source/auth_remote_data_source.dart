import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<UserModel>> signUp(SignupRequestModel userModel);

  
}