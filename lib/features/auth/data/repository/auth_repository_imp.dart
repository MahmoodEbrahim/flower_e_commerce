
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';


import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';

import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {

  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);

  Future<ApiResult<LoginModel>> login(String email,String password)async{
    return  await authRemoteDataSource.login(email, password);
  }
  

  Future<ApiResult<ForgetPasswordResponse>> forgetPassword
      (ForgetPasswordRequest request) async {
    return await authRemoteDataSource.forgetPassword(request);
  }
  @override
  Future<ApiResult<VerfiyPasswordResponse>> verfiyPassword(VerfiyPasswordRequest request)async {
    // TODO: implement verfiyPassword
    return await authRemoteDataSource.verfiyPassword(request);
  }
  @override
  Future<ApiResult<ResetPasswordResponsea>>
  resetPassword(ResetPasswordRequest request) async{
    // TODO: implement resetPassword
    return await authRemoteDataSource.resetPassword(request);  }

}