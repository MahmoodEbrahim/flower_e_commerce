import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase{
  AuthRepository _authRepository;
  GetProfileDataUseCase(this._authRepository);
  Future<ApiResult<UserModel>>getProfileData(String token)async{
    return await _authRepository.getProfileData(token);
  }
}