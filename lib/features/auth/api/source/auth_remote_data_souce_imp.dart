import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSouceImp  implements AuthRemoteDataSource{
AuthApiService _apiService;
AuthRemoteDataSouceImp(this._apiService);
  @override
  Future<ApiResult<ForgetPasswordResponse>>
forgetPassword(ForgetPasswordRequest request) async{
 try{
   final response=await _apiService.forgetPassword(request);
   if(response.message=="success"){
     return ApiSucessResult(response);
   }
   else{
     return ApiFailedResult(response.message!);
   }
 }catch(error){
   return ApiFailedResult(error.toString());
 }
  }
  @override
  Future<ApiResult<VerfiyPasswordResponse>> verfiyPassword
      (VerfiyPasswordRequest request)async {
  try{
    final response=await _apiService.verfiyPassword(request);

   if(response.status=="Success"){
return ApiSucessResult(response);
   }else{
    // VerfiyPasswordErrorResponse? verfiyPasswordErrorResponse;
return ApiFailedResult(response.status!);
   }
  }catch(error){
    return ApiFailedResult(error.toString()!);
  }
  }
  @override
  Future<ApiResult<ResetPasswordResponsea>>
  resetPassword(ResetPasswordRequest request) async{
    try{
      final response=await _apiService.resetPassword(request);
      if(response.message=="success"){
        return ApiSucessResult(response);
      }
      else{
        return ApiFailedResult(response.message!);
      }
    }catch(error){
      return ApiFailedResult(error.toString());
    }
  }
}