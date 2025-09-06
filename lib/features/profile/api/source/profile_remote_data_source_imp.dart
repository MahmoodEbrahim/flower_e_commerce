import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final ProfileApiService _profileApiService;
  ProfileRemoteDataSourceImp(this._profileApiService);
 @override
  Future<ApiResult<UploadProfilePhotoResponse>>
 uploadPhoto(String token, File photo) async{
  try{
final response=await _profileApiService.uploadPhoto
  ("Bearer $token", photo);
return ApiSucessResult(response);
  }catch(error){
if(error is DioException){
  return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
}else{
  return ApiFailedResult(error.toString());
}
  }
  }
  @override
  Future<ApiResult<EditProfileResponsea>>
  editProfile(String token, EditProfileRequest request)async {
    try{
      final response=await _profileApiService.editProfile
        ("Bearer $token", request);
      return ApiSucessResult(response);
    }catch(error){
      if(error is DioException){
        return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
      }else{
        return ApiFailedResult(error.toString());
      }
    }
  }
 @override
  Future<ApiResult<ChangePasswordResponse>>
 changePassword(ChangePasswordRequest request,String token) async{
  try{
    final response = await _profileApiService.changePassword(
      {"password": request.password, "newPassword": request.newPassword},
      "Bearer $token",
    );
if(response.message=="success"){
return ApiSucessResult(response);
}else{
return ApiFailedResult(ServerFailure("Something went wrong").errorMessage);
}
  }on DioException catch(error){
    return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
  }
  catch(error){
    return ApiFailedResult(error.toString());
  }
  }
}
