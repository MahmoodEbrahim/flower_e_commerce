import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase{
  AuthRepository _authRepository;
  ResetPasswordUseCase(this._authRepository);
  Future<ApiResult<ResetPasswordResponsea>>
  resetPassword(ResetPasswordRequest request)async{
    return await _authRepository.resetPassword(request);
  }
}