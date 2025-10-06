import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/sign_out_response/sign_out_response.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLogOutUseCase {
  AuthRepository authRepository;
  GetLogOutUseCase(this.authRepository);
  Future<Result<SignOutResponse>> logOut(String token) async {
    return await authRepository.logOut(token);
  }
}
