import 'dart:io';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/data/source/local/profile_local_data_source.dart';
import 'package:flower_e_commerce/features/profile/data/source/remote/profile_remote_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;
  ProfileRepositoryImp(this._profileRemoteDataSource,this._profileLocalDataSource);
@override
  Future<ApiResult<UploadProfilePhotoResponse>>
uploadPhoto(String token, File photo) async{
    // TODO: implement uploadPhoto
    return await _profileRemoteDataSource.uploadPhoto(token, photo);
  }
  @override
  Future<ApiResult<EditProfileResponsea>>
  editProfile(String token, EditProfileRequest request) async {
    // TODO: implement editProfile
    return await _profileRemoteDataSource.editProfile(token, request);
  }
@override
  Future<ApiResult<ChangePasswordResponse>> changePassword
    (ChangePasswordRequest request, String token) async{
  return await _profileRemoteDataSource.changePassword(request, token);
  }

  @override
  Future<ApiResult<List<GenericJsonSectionEntity>>> getJsonSections(String jsonPath,String jsonKey) async{
    return await _profileLocalDataSource.getJsonSections(jsonPath,jsonKey);
  }
}