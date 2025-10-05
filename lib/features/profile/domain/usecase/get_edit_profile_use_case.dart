import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEditProfileUseCase{
  final ProfileRepository _profileRepository;
  GetEditProfileUseCase(this._profileRepository);
  Future<ApiResult<EditProfileResponsea>>
  editProfile(String token, EditProfileRequest request)async{
    return await _profileRepository.editProfile(token, request);
  }
}