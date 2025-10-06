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
import 'package:flower_e_commerce/features/profile/data/source/remote/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final ProfileApiService _profileApiService;
  ProfileRemoteDataSourceImp(this._profileApiService);
  @override
  Future<Result<UploadProfilePhotoResponse>> uploadPhoto(
    String token,
    File photo,
  ) async {
    try {
      final response = await _profileApiService.uploadPhoto(
        "Bearer $token",
        photo,
      );
      return SucessResult(response);
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }

  @override
  Future<Result<EditProfileResponsea>> editProfile(
    String token,
    EditProfileRequest request,
  ) async {
    try {
      final response = await _profileApiService.editProfile(
        "Bearer $token",
        request,
      );
      return SucessResult(response);
    } catch (error) {
      if (error is DioException) {
        return FailedResult(ServerFailure.fromDioError(error).errorMessage);
      } else {
        return FailedResult(error.toString());
      }
    }
  }

  @override
  Future<Result<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
    String token,
  ) async {
    try {
      final response = await _profileApiService.changePassword({
        "password": request.password,
        "newPassword": request.newPassword,
      }, "Bearer $token");
      if (response.message == "success") {
        return SucessResult(response);
      } else {
        return FailedResult(ServerFailure("Something went wrong").errorMessage);
      }
    } on DioException catch (error) {
      return FailedResult(ServerFailure.fromDioError(error).errorMessage);
    } catch (error) {
      return FailedResult(error.toString());
    }
  }
}
