import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<ForgetPasswordResponse>>forgetPassword(ForgetPasswordRequest request);
  Future<ApiResult<VerfiyPasswordResponse>>verfiyPassword(VerfiyPasswordRequest request);
  Future<ApiResult<ResetPasswordResponsea>>
  resetPassword(ResetPasswordRequest request);

}