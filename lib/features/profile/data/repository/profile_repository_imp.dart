

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  ProfileRepositoryImp(this._profileRemoteDataSource);
@override
  Future<ApiResult<ChangePasswordResponse>> changePassword
    (ChangePasswordRequest request, String token) async{
  return await _profileRemoteDataSource.changePassword(request, token);
  }
}