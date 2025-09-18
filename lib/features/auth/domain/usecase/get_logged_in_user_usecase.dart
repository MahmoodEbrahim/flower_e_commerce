import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';

class GetLoggedInUserUseCase {
  final AuthRepository authRepository;

  GetLoggedInUserUseCase(this.authRepository);

  Future<ApiResult<UserModel>> call() {
    return authRepository.getLoggedInUser();
  }
}

