
import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';

abstract interface class ProfileRepository {
  Future<ApiResult<UploadProfilePhotoResponse>>uploadPhoto(

      String token,File photo
      );
}