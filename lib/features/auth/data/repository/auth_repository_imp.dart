import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp(this.authRemoteDataSource);

  Future<ApiResult<LoginModel>> login(String email,String password)async{
    return  await authRemoteDataSource.login(email, password);
  }
  
}