import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerfiyPasswordUseCase{
  AuthRepository _authRepository;
  VerfiyPasswordUseCase(this._authRepository);
  Future<ApiResult<VerfiyPasswordResponse>>
  verfiyPassword(VerfiyPasswordRequest request)async{
    return _authRepository.verfiyPassword(request);
  }
}