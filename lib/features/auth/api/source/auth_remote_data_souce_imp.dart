import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/responses/login_response.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthApiService authApiService;

  AuthRemoteDataSourceImp(this.authApiService);

  @override
  Future<ApiResult<LoginEntity>> login(String email, String password) async {
    try {
      LoginResponse response =
          await authApiService.logIn({"email": email, "password": password});

      return ApiSuccessResult<LoginEntity>(response.toLoginEntity());
    } catch (e) {
      if (e is DioException) {
        return ApiErrorResult<LoginEntity>(e.message ?? e.toString());
      }
      return ApiErrorResult<LoginEntity>(
          e.toString()); // T is signature means --> error for logon entity
    }
  }
}
