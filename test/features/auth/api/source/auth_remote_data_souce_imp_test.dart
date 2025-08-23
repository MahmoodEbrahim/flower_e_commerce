import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_error_response.dart';
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
  test('TODO: Implement tests for auth_remote_data_souce_imp.dart', () {
    // TODO: Implement test
  });
 late MockAuthApiService mockAuthApiService;
 late   AuthRemoteDataSourceImp authRemoteDataSource;
setUp((){
  provideDummies();
  mockAuthApiService=MockAuthApiService();
  authRemoteDataSource=
      AuthRemoteDataSourceImp(mockAuthApiService);
});



  group("test Forget Password", (){
ForgetPasswordRequest forgetPasswordRequest=ForgetPasswordRequest();
final successResponse = ForgetPasswordResponse( message: "success",
    info: "OTP sent to your email");
final failureResponse = ForgetPasswordResponse
  (message: "There is no account with this email address  admin@.com");
    test("should return ApiSucessResult when calling api ", ()async{
      when(mockAuthApiService.forgetPassword(any))
          .thenAnswer((_)async=>successResponse);
      final result=await authRemoteDataSource.forgetPassword(forgetPasswordRequest);
   expect(result, isA<ApiSuccessResult<ForgetPasswordResponse>>());
   expect((result as ApiSuccessResult).data, successResponse);
   verify(mockAuthApiService.forgetPassword(forgetPasswordRequest)).called(1);
    });

    test("when return ApiFailedResult when calling api", ()async{
      when(mockAuthApiService.forgetPassword(any))
          .thenAnswer((_)async=>failureResponse);
      final result=await authRemoteDataSource.forgetPassword(forgetPasswordRequest);
 expect(result, isA<ApiErrorResult<ForgetPasswordResponse>>());
 var actualResult=(result as ApiErrorResult).errorMessage;
 expect(actualResult, failureResponse.message);
 verify(mockAuthApiService.forgetPassword(forgetPasswordRequest)).called(1);
    });
    test("should return ApiFailedResult when api call throws an exception", ()async{
      final exception=Exception("Network Problems");
      when(mockAuthApiService.forgetPassword(any)).
     thenThrow(exception);
      final result=await authRemoteDataSource.forgetPassword(forgetPasswordRequest);

expect(result, isA<ApiErrorResult<ForgetPasswordResponse>>());
var actualResult=(result as ApiErrorResult).errorMessage;
expect(actualResult, exception.toString());
verify(mockAuthApiService.forgetPassword(forgetPasswordRequest)).called(1);
    });


  });
  group("test Verify Password", (){
    VerfiyPasswordRequest verfiyPasswordRequest=VerfiyPasswordRequest();
    VerfiyPasswordResponse verfiyPasswordResponseSucess=VerfiyPasswordResponse(
        status: "success"
    );
    VerfiyPasswordResponse verfiyPasswordResponseFailure=VerfiyPasswordResponse(
   status: "Reset code is invalid or has expired"
    );
    test("should return ApiSucessResult when api call", ()async{
   
      when(mockAuthApiService.verfiyPassword(any)).
      thenAnswer((_)async=>verfiyPasswordResponseSucess);
      final result=await authRemoteDataSource.verfiyPassword(verfiyPasswordRequest);
      expect(result, isA<ApiSuccessResult<VerfiyPasswordResponse>>());
      var actualResult= (result as ApiSuccessResult).data;
      expect(actualResult, verfiyPasswordResponseSucess);
      verify(mockAuthApiService.verfiyPassword(verfiyPasswordRequest)).called(1);

    });
    test("should return ApiFailureResult when calling api ", ()async{
      when(mockAuthApiService.verfiyPassword(any))
          .thenAnswer((_) async => verfiyPasswordResponseFailure);

      final result = await authRemoteDataSource.verfiyPassword
        (verfiyPasswordRequest);

      expect(result, isA<ApiErrorResult<VerfiyPasswordResponse>>());
      expect((result as ApiErrorResult).errorMessage,
          verfiyPasswordResponseFailure.status);
      verify(mockAuthApiService.verfiyPassword(verfiyPasswordRequest)).called(1);
      
    });
    test("should return ApiFailureResult when throw excepion", ()async{
      final exception=Exception("Network problem");
      when(mockAuthApiService.verfiyPassword(any)).thenThrow(exception);
      final result=await authRemoteDataSource.verfiyPassword(verfiyPasswordRequest);
      expect(result, isA<ApiErrorResult<VerfiyPasswordResponse>>());
      var actualResult=(result as ApiErrorResult).errorMessage;
      expect(actualResult, exception.toString());
      verify(mockAuthApiService.verfiyPassword(verfiyPasswordRequest)).called(1);
    });
  });
  group("test Reset password ", () {
    ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest();
    ResetPasswordResponsea resetPasswordResponsea = ResetPasswordResponsea(
        message: "success",
        token: "AqwertyuSertyuioDFrtyuiopGtyuioplkjhHfghjkJKL23456789PLKJHGwertyuidsertyuiop"
    );

    ResetPasswordResponsea resetPasswordErrorResponsea = ResetPasswordResponsea(
      message: "reset code not verified",
    );
    test("should return ApiSuccessResult when calling api", () async {
      when(mockAuthApiService.resetPassword(any)).thenAnswer((_) async =>
      resetPasswordResponsea);
      final result = await authRemoteDataSource.resetPassword(
          resetPasswordRequest);
      expect(result, isA<ApiSuccessResult<ResetPasswordResponsea>>());
      var actualResult = (result as ApiSuccessResult).data;
      expect(actualResult, resetPasswordResponsea);
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
    test('should return ApiFailedResult when calling api', () async {
      when(mockAuthApiService.resetPassword(any))
          .thenAnswer((answer) async => resetPasswordErrorResponsea);

      final result = await authRemoteDataSource.resetPassword(
          resetPasswordRequest);

      expect((result as ApiErrorResult).errorMessage,
          resetPasswordErrorResponsea.message!.toString());
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
    test("should return ApiFailedResult when throw exception", ()async{
      final exception=Exception("Network Problems");
      when(mockAuthApiService.resetPassword(any)).thenThrow(exception);
      final result=await authRemoteDataSource.resetPassword(resetPasswordRequest);
      expect(result, isA<ApiErrorResult<ResetPasswordResponsea>>());
      expect((result as ApiErrorResult).errorMessage, exception.toString());
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
  });

}