import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoginUsecase {
  AuthRepository authRepository;
  LoginUsecase(this.authRepository);

  Future<ApiResult<LoginModel>> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
