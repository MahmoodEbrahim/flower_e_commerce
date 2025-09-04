
import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ApiResult<UploadProfilePhotoResponse>>uploadPhoto(

      String token,File photo
      );
  Future<ApiResult<EditProfileResponsea>>editProfile(
      String token,
    EditProfileRequest request
      );
  Future<ApiResult<ChangePasswordResponse>>
  changePassword(ChangePasswordRequest request,String token);
}