import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/core/utils/constants/api_parameters.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'profile_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;
@PUT(ApiEndPoints.uploadProfileEndPoint)
@MultiPart()
  Future<UploadProfilePhotoResponse>uploadPhoto(
@Header("Authorization")String token,
  @Part(name: 'photo')File photo
    );
@PUT(ApiEndPoints.editProfileEndPoint)
  Future<EditProfileResponsea>editProfile(
    @Header("Authorization")String token,
    @Body()EditProfileRequest request
    );

@PATCH(ApiEndPoints.changePasswordEndPoint)
  Future<ChangePasswordResponse>changePassword(
    @Body()Map<String, dynamic> request,
    @Header(ApiParameters.authorization) String token
    );
}
