import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_response/auth_response_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthApiService authApiService;

  AuthRemoteDataSourceImp(this.authApiService);

  @override
  Future<ApiResult<LoginModel>> login(String email, String password) async {
    try {
      AuthResponseDto response =
          await authApiService.logIn({"email": email, "password": password});

      return ApiSuccessResult<LoginModel>(response.toLoginEntity());
    } catch (e) {
      if (e is DioException) {
        return ApiErrorResult<LoginModel>(e.message ?? e.toString());
      }
      return ApiErrorResult<LoginModel>(
          e.toString()); // T is signature means --> error for login entity
    }
  }
}
