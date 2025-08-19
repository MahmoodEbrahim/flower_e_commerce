import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/signup_request/signup_request_dto.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSouceImp implements AuthRemoteDataSource {
  final AuthApiService _apiService;
  AuthRemoteDataSouceImp(this._apiService);
  //! do not forget tokenservice

  @override
  Future<ApiResult<UserModel>> signUp(SignupRequestModel userModel) async {
    try {
      final signupResponse =
          await _apiService.signUp(SignupRequestDto.toDto(userModel));

      return ApiSucessResult(signupResponse.user!.toUserModel());
    }

   on DioException catch (e) {
      final data = e.response?.data;
      String errorMessage = e.toString();

      if (data is Map<String, dynamic> &&
          data.containsKey("message")) {
        errorMessage = data["message"].toString();
      }

      return ApiFailedResult(errorMessage);
    } catch (e) {
      return ApiFailedResult(e.toString());
    }
    
    
    
    
    
    
  }
}
