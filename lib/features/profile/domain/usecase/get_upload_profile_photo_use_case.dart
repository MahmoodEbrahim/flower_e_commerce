import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUploadPhotoProfileUseCase {
  final ProfileRepository _profileRepository;
  GetUploadPhotoProfileUseCase(this._profileRepository);
  Future<Result<UploadProfilePhotoResponse>> uploadPhoto(
    String token,
    File photo,
  ) async {
    return await _profileRepository.uploadPhoto(token, photo);
  }
}
