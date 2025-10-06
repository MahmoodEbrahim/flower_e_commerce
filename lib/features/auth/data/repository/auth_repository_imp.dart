import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/sign_out_response/sign_out_response.dart';

import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);

  @override
  Future<Result<LoginModel>> login(String email, String password) async {
    return await authRemoteDataSource.login(email, password);
  }

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    return await authRemoteDataSource.forgetPassword(request);
  }

  @override
  Future<Result<VerfiyPasswordResponse>> verfiyPassword(
    VerfiyPasswordRequest request,
  ) async {
    // TODO: implement verfiyPassword
    return await authRemoteDataSource.verfiyPassword(request);
  }

  @override
  Future<Result<ResetPasswordResponsea>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    return await authRemoteDataSource.resetPassword(request);
  }

  @override
  Future<Result<UserModel>> signUp(SignupRequestModel userModel) async {
    return await authRemoteDataSource.signUp(userModel);
  }

  @override
  Future<Result<UserModel>> getProfileData(String token) async {
    // TODO: implement getProfileData
    return await authRemoteDataSource.getProfileData(token);
  }

  @override
  Future<Result<SignOutResponse>> logOut(String token) async {
    // TODO: implement logOut
    return await authRemoteDataSource.logOut(token);
  }
}
