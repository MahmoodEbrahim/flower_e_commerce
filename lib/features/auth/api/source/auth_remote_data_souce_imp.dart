import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';

import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/sign_out_response/sign_out_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/signup_request/signup_request_dto.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_response/auth_response_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  AuthApiService authApiService;

  AuthRemoteDataSourceImp(this.authApiService);

  @override
  Future<Result<LoginModel>> login(String email, String password) async {
    try {
      AuthResponseDto response = await authApiService.logIn({
        "email": email,
        "password": password,
      });

      return SucessResult<LoginModel>(response.toLoginModel());
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
      return FailedResult<LoginModel>(message);
    } catch (e) {
      return FailedResult<LoginModel>(e.toString());
    }
  }

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword(
    ForgetPasswordRequest request,
  ) async {
    try {
      final response = await authApiService.forgetPassword(request);
      if (response.message == "success") {
        return SucessResult(response);
      } else {
        return FailedResult(
          ServerFailure(
            "There is no account with this email address",
          ).errorMessage,
        );
      }
    } on DioException catch (e) {
      return FailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return FailedResult(error.toString());
    }
  }

  @override
  Future<Result<VerfiyPasswordResponse>> verfiyPassword(
    VerfiyPasswordRequest request,
  ) async {
    try {
      final response = await authApiService.verfiyPassword(request);

      if (response.status == "Success") {
        return SucessResult(response);
      } else {
        return FailedResult(
          ServerFailure(
            response.status ?? 'Reset code is invalid or has expired',
          ).errorMessage,
        );
      }
    } on DioException catch (e) {
      return FailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return FailedResult(ServerFailure(error.toString()).errorMessage);
    }
  }

  @override
  Future<Result<ResetPasswordResponsea>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await authApiService.resetPassword(request);
      if (response.message == "success") {
        return SucessResult(response);
      } else {
        return FailedResult(
          ServerFailure("reset code not verified").errorMessage,
        );
      }
    } on DioException catch (e) {
      return FailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return FailedResult(error.toString());
    }
  }

  @override
  Future<Result<UserModel>> signUp(SignupRequestModel userModel) async {
    try {
      final signupResponse = await authApiService.signUp(
        SignupRequestDto.toDto(userModel),
      );

      return SucessResult(signupResponse.user!.toUserModel());
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }

      return FailedResult(errorMessage);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }

  @override
  Future<Result<UserModel>> getProfileData(String token) async {
    try {
      final response = await authApiService.getProfile("Bearer $token");
      return SucessResult(response.user!.toEntity());
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }

  @override
  Future<Result<SignOutResponse>> logOut(String token) async {
    try {
      final response = await authApiService.logOut("Bearer $token");
      return SucessResult(response);
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }
}
