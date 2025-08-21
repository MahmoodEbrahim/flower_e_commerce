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

      return ApiSuccessResult<LoginModel>(response.toLoginModel());
    } on DioException catch (e) {
      String message = "Something went wrong, please try again";

      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          message = "Invalid email or password";
        } else if (e.response?.statusCode == 500) {
          message = "Server error, try again later";
        } else {
          message = e.response?.data["message"] ?? message;
        }
      }
      return ApiErrorResult<LoginModel>(message);
    } catch (e) {
      return ApiErrorResult<LoginModel>(e.toString());
    }
  }
}
