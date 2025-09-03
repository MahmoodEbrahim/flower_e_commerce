

import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImp(this._profileRemoteDataSource);
@override
  Future<ApiResult<UploadProfilePhotoResponse>>
uploadPhoto(String token, File photo) async{
    // TODO: implement uploadPhoto
    return await _profileRemoteDataSource.uploadPhoto(token, photo);
  }
}