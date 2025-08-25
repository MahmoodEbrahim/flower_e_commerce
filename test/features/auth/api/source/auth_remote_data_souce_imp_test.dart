import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/source/auth_remote_data_souce_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_remote_data_souce_imp_test.mocks.dart';

void provideDummies() {
  provideDummy<ApiResult<ForgetPasswordResponse>>(
    ApiErrorResult<ForgetPasswordResponse>('Dummy error'),
  );
  provideDummy<ApiResult<VerfiyPasswordResponse>>(
    ApiErrorResult<VerfiyPasswordResponse>('Dummy error'),
  );
  provideDummy<ApiResult<ResetPasswordResponsea>>(
    ApiErrorResult<ResetPasswordResponsea>('Dummy error'),
  );
}

@GenerateMocks([AuthApiService])
void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRemoteDataSourceImp authRemoteDataSource;
  setUp(() {
    provideDummies();
    mockAuthApiService = MockAuthApiService();
    authRemoteDataSource = AuthRemoteDataSourceImp(mockAuthApiService);
  });

  group("test Forget Password", () {
    ForgetPasswordRequest request = ForgetPasswordRequest();
    final successResponse = ForgetPasswordResponse(
        message: "success", info: "OTP sent to your email");
    final failureResponse = ForgetPasswordResponse(
        message: "There is no account with this email address");
    test("should return ApiSuccessResult when calling api success", () async {
      when(mockAuthApiService.forgetPassword(any))
          .thenAnswer((_) async => successResponse);
      final result = await authRemoteDataSource.forgetPassword(request);
      expect(result, isA<ApiSuccessResult<ForgetPasswordResponse>>());
      expect((result as ApiSuccessResult).data, successResponse);
      verify(mockAuthApiService.forgetPassword(request)).called(1);
    });
    test('should return ApiFailedResult when API returns failure message',
            () async {
          // Arrange

          final forgetPasswordRequest =
          ForgetPasswordRequest(email: 'test@example.com');
          final failureResponse = ForgetPasswordResponse(message: 'failure');
          when(mockAuthApiService.forgetPassword(any))
              .thenAnswer((_) async => failureResponse);

          final result =
          await authRemoteDataSource.forgetPassword(forgetPasswordRequest);
          expect(result, isA<ApiErrorResult>());
          expect((result as ApiErrorResult).errorMessage,
              contains('There is no account with this email address'));
        });
    test("should return ApiFailedResult when  throw exception", ()async{
      final exception=Exception("Throw Exception");
      when(mockAuthApiService.forgetPassword(any))
          .thenThrow(Exception("Throw Exception"));
      final result=await authRemoteDataSource.forgetPassword(request);
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, exception.toString());
      verify(mockAuthApiService.forgetPassword(request)).called(1);
    });
  });

  group("Verify Password", () {
    VerfiyPasswordRequest request = VerfiyPasswordRequest(resetCode: "930926");
    final successResponse = VerfiyPasswordResponse(status: "Success");
    final failurResponse =
    VerfiyPasswordResponse(status: "Reset code is invalid or has expired");
    test("should return ApiSuccessResult when calling api success", () async {
      when(mockAuthApiService.verfiyPassword(request))
          .thenAnswer((_) async => successResponse);
      final result = await authRemoteDataSource.verfiyPassword(request);
      expect(result, isA<ApiSuccessResult<VerfiyPasswordResponse>>());
      expect((result as ApiSuccessResult).data, successResponse);
      verify(mockAuthApiService.verfiyPassword(request)).called(1);
    });
    test("should return ApiFailedResult when calling api failed", () async {
      when(mockAuthApiService.verfiyPassword(any))
          .thenAnswer((_) async => failurResponse);
      final result = await authRemoteDataSource.verfiyPassword(request);
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, failurResponse.status);
    });
    test("should return ApiFailedResult when  throw exception", ()async{
      final exception=Exception("Throw Exception");
      when(mockAuthApiService.verfiyPassword(any)).thenThrow(Exception("Throw Exception"));
      final result=await authRemoteDataSource.verfiyPassword(request);
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, exception.toString());
    });
  });

  group("Reset Password", () {
    ResetPasswordRequest request = ResetPasswordRequest(
        email: "mariammohmed.25720@gmail.com", newPassword: "Marew123@");
    final successResponse = ResetPasswordResponsea(
        message: "success",
        token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTIxODI1YThiY2EzMDdmOWRlOTM2NSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzU2MTEzODgzfQ.B4dZ4Jj9wtfKj4ArdVF7OF2KYFm4M3kRd-5teDbRbT0");
    final failureResponse =
    ResetPasswordResponsea(message: "reset code not verified");

    test("should return ApiSuccessResult when calling api success", () async {
      when(mockAuthApiService.resetPassword(request))
          .thenAnswer((_) async => successResponse);
      final result = await authRemoteDataSource.resetPassword(request);
      expect(result, isA<ApiSuccessResult<ResetPasswordResponsea>>());
      expect((result as ApiSuccessResult).data, successResponse);
      verify(mockAuthApiService.resetPassword(request)).called(1);
    });
    test("should return ApiFailedResult when calling api failed", ()async{
      when(mockAuthApiService.resetPassword(any)).thenAnswer((_)
      async=>failureResponse);
      final result=await authRemoteDataSource.resetPassword(request);
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, failureResponse.message);
    });
    test("should return ApiFailedResult when  throw exception", ()async{
      final exception=Exception("Throw Exception");
      when(mockAuthApiService.resetPassword(any)).thenThrow(Exception("Throw Exception"));
      final result=await authRemoteDataSource.resetPassword(request);
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, exception.toString());

    });
  });
}