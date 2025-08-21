import 'package:flower_e_commerce/core/api_result/api_result.dart';
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
    ApiFailedResult<ForgetPasswordResponse>('Dummy error'),
  );
  provideDummy<ApiResult<VerfiyPasswordResponse>>(
    ApiFailedResult<VerfiyPasswordResponse>('Dummy error'),
  );
  provideDummy<ApiResult<ResetPasswordResponsea>>(
    ApiFailedResult<ResetPasswordResponsea>('Dummy error'),
  );
}
@GenerateMocks([AuthApiService])
void main() {
  test('TODO: Implement tests for auth_remote_data_souce_imp.dart', () {
    // TODO: Implement test
  });
 late MockAuthApiService mockAuthApiService;
 late   AuthRemoteDataSouceImp authRemoteDataSource;
setUp((){
  provideDummies();mockAuthApiService=MockAuthApiService();
  authRemoteDataSource=
      AuthRemoteDataSouceImp(mockAuthApiService);
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
   expect(result, isA<ApiSucessResult<ForgetPasswordResponse>>());
   expect((result as ApiSucessResult).sucessResult, successResponse);
   verify(mockAuthApiService.forgetPassword(forgetPasswordRequest)).called(1);
    });

    test("when return ApiFailedResult when calling api", ()async{
      when(mockAuthApiService.forgetPassword(any))
          .thenAnswer((_)async=>failureResponse);
      final result=await authRemoteDataSource.forgetPassword(forgetPasswordRequest);
 expect(result, isA<ApiFailedResult<ForgetPasswordResponse>>());
 var actualResult=(result as ApiFailedResult).errorMessage;
 expect(actualResult, failureResponse.message);
 verify(mockAuthApiService.forgetPassword(forgetPasswordRequest)).called(1);
    });
    test("should return ApiFailedResult when api call throws an exception", ()async{
      final exception=Exception("Network Problems");
      when(mockAuthApiService.forgetPassword(any)).
     thenThrow(exception);
      final result=await authRemoteDataSource.forgetPassword(forgetPasswordRequest);

expect(result, isA<ApiFailedResult<ForgetPasswordResponse>>());
var actualResult=(result as ApiFailedResult).errorMessage;
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
      expect(result, isA<ApiSucessResult<VerfiyPasswordResponse>>());
      var actualResult= (result as ApiSucessResult).sucessResult;
      expect(actualResult, verfiyPasswordResponseSucess);
      verify(mockAuthApiService.verfiyPassword(verfiyPasswordRequest)).called(1);

    });
    test("should return ApiFailureResult when calling api ", ()async{
      when(mockAuthApiService.verfiyPassword(any))
          .thenAnswer((_) async => verfiyPasswordResponseFailure);

      final result = await authRemoteDataSource.verfiyPassword
        (verfiyPasswordRequest);

      expect(result, isA<ApiFailedResult<VerfiyPasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage,
          verfiyPasswordResponseFailure.status);
      verify(mockAuthApiService.verfiyPassword(verfiyPasswordRequest)).called(1);
      
    });
    test("should return ApiFailureResult when throw excepion", ()async{
      final exception=Exception("Network problem");
      when(mockAuthApiService.verfiyPassword(any)).thenThrow(exception);
      final result=await authRemoteDataSource.verfiyPassword(verfiyPasswordRequest);
      expect(result, isA<ApiFailedResult<VerfiyPasswordResponse>>());
      var actualResult=(result as ApiFailedResult).errorMessage;
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
      expect(result, isA<ApiSucessResult<ResetPasswordResponsea>>());
      var actualResult = (result as ApiSucessResult).sucessResult;
      expect(actualResult, resetPasswordResponsea);
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
    test('should return ApiFailedResult when calling api', () async {
      when(mockAuthApiService.resetPassword(any))
          .thenAnswer((answer) async => resetPasswordErrorResponsea);

      final result = await authRemoteDataSource.resetPassword(
          resetPasswordRequest);

      expect(result, isA<ApiFailedResult<ResetPasswordResponsea>>());
      expect((result as ApiFailedResult).errorMessage,
          resetPasswordErrorResponsea.message!.toString());
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
    test("should return ApiFailedResult when throw exception", ()async{
      final exception=Exception("Network Problems");
      when(mockAuthApiService.resetPassword(any)).thenThrow(exception);
      final result=await authRemoteDataSource.resetPassword(resetPasswordRequest);
      expect(result, isA<ApiFailedResult<ResetPasswordResponsea>>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockAuthApiService.resetPassword(resetPasswordRequest)).called(1);
    });
  });

}