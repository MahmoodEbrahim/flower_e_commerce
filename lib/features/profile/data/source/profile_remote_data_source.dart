
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ApiResult<ChangePasswordResponse>>
  changePassword(ChangePasswordRequest request,String token);
}