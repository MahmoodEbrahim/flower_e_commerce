
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/utils/constants/api_end_points.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiUrl+ApiEndPoints.authEndPoint)
@injectable
abstract class AuthApiService {

  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

@POST(ApiEndPoints.forgetPasswordEndPoint)
  Future<ForgetPasswordResponse>forgetPassword(
    @Body()ForgetPasswordRequest request
    );

}