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
  Future<ApiResult<LoginModel>> login(String email, String password) async {
    try {
      AuthResponseDto response =
      await authApiService.logIn({"email": email, "password": password});

      return ApiSucessResult<LoginModel>(response.toLoginModel());
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
      return ApiFailedResult<LoginModel>(message);
    } catch (e) {
      return ApiFailedResult<LoginModel>(e.toString());
    }
  }
  @override
  Future<ApiResult<ForgetPasswordResponse>> forgetPassword(
      ForgetPasswordRequest request) async
  {
    try {
      final response = await authApiService.forgetPassword(request);
      if(response.message=="success"){
        return ApiSucessResult(response);
      }else{
        return ApiFailedResult(ServerFailure("There is no account with this email address").errorMessage);
      }

    } on DioException catch (e) {
      return ApiFailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return ApiFailedResult(error.toString());
    }
  }

  @override
  Future<ApiResult<VerfiyPasswordResponse>> verfiyPassword
      (VerfiyPasswordRequest request) async {
    try {
      final response = await authApiService.verfiyPassword(request);
     
      if (response.status == "Success") {
      
        return ApiSucessResult(response);
      } else {
        return ApiFailedResult(ServerFailure(response.status??
            'Reset code is invalid or has expired').errorMessage);
      }
    } on DioException catch (e) {
      return ApiFailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return ApiFailedResult(ServerFailure(error.toString()).errorMessage);
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponsea>> resetPassword(
      ResetPasswordRequest request) async {
    try {
      final response = await authApiService.resetPassword(request);
      if(response.message=="success"){
        return ApiSucessResult(response);
      }else{
        return ApiFailedResult(ServerFailure("reset code not verified").errorMessage);
      }
    } on DioException catch (e) {
      return ApiFailedResult(ServerFailure.fromDioError(e).errorMessage);
    } catch (error) {
      return ApiFailedResult(error.toString());
    }
  }



  @override
  Future<ApiResult<UserModel>> signUp(SignupRequestModel userModel) async {
    try {
      final signupResponse =
          await authApiService.signUp(SignupRequestDto.toDto(userModel));

      return ApiSucessResult(signupResponse.user!.toUserModel());
    } on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.message!;

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        errorMessage = data["error"].toString();
      }
      

      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
  }


}