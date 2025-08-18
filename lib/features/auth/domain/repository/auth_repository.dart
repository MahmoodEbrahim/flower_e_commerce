import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';

abstract interface class AuthRepository {
  Future<ApiResult<ForgetPasswordResponse>>forgetPassword(
      ForgetPasswordRequest request
      );
}