
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {
  AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImp(this._authRemoteDataSource);
  @override
  Future<ApiResult<ForgetPasswordResponse>> forgetPassword
      (ForgetPasswordRequest request) async {
    return await _authRemoteDataSource.forgetPassword(request);
  }
  @override
  Future<ApiResult<VerfiyPasswordResponse>> verfiyPassword(VerfiyPasswordRequest request)async {
    // TODO: implement verfiyPassword
    return await _authRemoteDataSource.verfiyPassword(request);
  }
}