import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class SignupUsecase {
  final AuthRepository _authRepo;
  SignupUsecase(this._authRepo);

  Future<ApiResult<UserModel>> signUp(SignupRequestModel userModel) async {
    return await _authRepo.signUp(userModel);
  }

}