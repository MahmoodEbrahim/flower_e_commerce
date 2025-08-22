import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordUseCase{
  AuthRepository _authRepository;
  ForgetPasswordUseCase(this._authRepository);
  Future<ApiResult<ForgetPasswordResponse>>
  forgetPassword(ForgetPasswordRequest request)async{
    return await _authRepository.forgetPassword(request);
  }
}