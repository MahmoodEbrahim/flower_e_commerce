
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';

// Generate mocks for AuthRemoteDataSource
@GenerateMocks([AuthRemoteDataSource])
import 'auth_repository_imp_test.mocks.dart';
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

void main() {

  late AuthRepositoryImp authRepository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    provideDummies();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepository = AuthRepositoryImp(mockAuthRemoteDataSource);
  });

  group('AuthRepositoryImp', () {

group("Forget Password ", (){
  ForgetPasswordRequest request=ForgetPasswordRequest();
  ForgetPasswordResponse successResponse=ForgetPasswordResponse(
      message: "success",
      info: "OTP sent to your email"
  );
  final failureResponse=ApiFailedResult<ForgetPasswordResponse>("There is no account with this email address  admin@.com");
  test("should return ApiSuccessResult when data source call", ()async{
    when(mockAuthRemoteDataSource.forgetPassword(request)).
    thenAnswer((_)async=>ApiSucessResult(successResponse));
    final result=await authRepository.forgetPassword(request);
    expect(result, isA<ApiSucessResult<ForgetPasswordResponse>>());
    expect((result as ApiSucessResult).sucessResult, successResponse);
    verify(mockAuthRemoteDataSource.forgetPassword(request)).called(1);
  });
  test("should return ApiFailedResult when data source call ", ()async{
    when(mockAuthRemoteDataSource.forgetPassword(request)).thenAnswer(
            (_)async=>ApiFailedResult(failureResponse.errorMessage));
    final result=await authRepository.forgetPassword(request);
    expect(result, isA<ApiFailedResult<ForgetPasswordResponse>>());
    expect((result as ApiFailedResult).errorMessage,failureResponse.errorMessage);
    verify(mockAuthRemoteDataSource.forgetPassword(request)).called(1);
  });

});
    group('Verfiy Password', () {
      VerfiyPasswordRequest verfiyPasswordRequest = VerfiyPasswordRequest();
      VerfiyPasswordResponse successResponse = VerfiyPasswordResponse(status: 'success');
      final failureResponse = ApiFailedResult<VerfiyPasswordResponse>('Invalid code');

      test('should return ApiSucessResult when data source returns success', () async {

        when(mockAuthRemoteDataSource.verfiyPassword(verfiyPasswordRequest))
            .thenAnswer((_) async => ApiSucessResult(successResponse));


        final result = await authRepository.verfiyPassword(verfiyPasswordRequest);


        expect(result, isA<ApiSucessResult<VerfiyPasswordResponse>>());
        expect((result as ApiSucessResult).sucessResult, successResponse);
        verify(mockAuthRemoteDataSource.verfiyPassword(verfiyPasswordRequest)).called(1);
      });

      test('should return ApiFailedResult when data source returns failure', () async {
        when(mockAuthRemoteDataSource.verfiyPassword(verfiyPasswordRequest))
            .thenAnswer((_) async => failureResponse);


        final result = await authRepository.verfiyPassword(verfiyPasswordRequest);


        expect(result, isA<ApiFailedResult<VerfiyPasswordResponse>>());
        expect((result as ApiFailedResult).errorMessage, failureResponse.errorMessage);
        verify(mockAuthRemoteDataSource.verfiyPassword(verfiyPasswordRequest)).called(1);
      });
    });

    group('resetPassword', () {
      ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest();
      ResetPasswordResponsea successResponse = ResetPasswordResponsea(
        message: 'success',
        token: 'AqwertyuSertyuioDFrtyuiopGtyuioplkjhHfghjkJKL23456789PLKJHGwertyuidsertyuiop',
      );
      final failureResponse = ApiFailedResult<ResetPasswordResponsea>('reset code not verified');

      test('should return ApiSucessResult when data source returns success', () async {
        when(mockAuthRemoteDataSource.resetPassword(resetPasswordRequest))
            .thenAnswer((_) async => ApiSucessResult(successResponse));

        final result = await authRepository.resetPassword(resetPasswordRequest);

        expect(result, isA<ApiSucessResult<ResetPasswordResponsea>>());
        expect((result as ApiSucessResult).sucessResult, successResponse);
        verify(mockAuthRemoteDataSource.resetPassword(resetPasswordRequest)).called(1);
      });

      test('should return ApiFailedResult when data source returns failure', () async {

        when(mockAuthRemoteDataSource.resetPassword(resetPasswordRequest))
            .thenAnswer((_) async => failureResponse);

        final result = await authRepository.resetPassword(resetPasswordRequest);

        expect(result, isA<ApiFailedResult<ResetPasswordResponsea>>());
        expect((result as ApiFailedResult).errorMessage, failureResponse.errorMessage);
        verify(mockAuthRemoteDataSource.resetPassword(resetPasswordRequest)).called(1);
      });
    });
  });
}

