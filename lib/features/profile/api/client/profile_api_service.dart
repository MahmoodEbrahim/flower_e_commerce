import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/core/utils/constants/api_parameters.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';


import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl)
@injectable
abstract class ProfileApiService {
  @factoryMethod

  factory ProfileApiService(Dio dio) = _ProfileApiService;
@PATCH(ApiEndPoints.changePasswordEndPoint)
  Future<ChangePasswordResponse>changePassword(
    @Body()Map<String, dynamic> request,
    @Header(ApiParameters.authorization) String token
    );
}
