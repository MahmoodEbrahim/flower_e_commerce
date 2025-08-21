import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/verfiy_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';

import 'verfiy_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void provideDummies(){
  provideDummy<ApiResult<ResetPasswordResponsea>>(
      ApiFailedResult<ResetPasswordResponsea>("error"));
}

void main() {

  late ResetPasswordUseCase resetPasswordUseCase;
late MockAuthRepository mockAuthRepository;
setUp((){
  provideDummies();
  mockAuthRepository=MockAuthRepository();
  resetPasswordUseCase=ResetPasswordUseCase(mockAuthRepository);
});
group("Reset Password ", (){
  ResetPasswordRequest request=ResetPasswordRequest();
  ResetPasswordResponsea successResponse=ResetPasswordResponsea(
    message: "success",token: "rtyuiolkbvcxawertyui"
  );
  final failureResponse=ApiFailedResult<ResetPasswordResponsea>("ERROR");
  test("should return ApiSuccessResult when retrurn Repo success",
      ()async{
when(mockAuthRepository.resetPassword(request))
    .thenAnswer((_)async=>ApiSucessResult(successResponse));
final result=await resetPasswordUseCase.resetPassword(request);
expect(result, isA<ApiSucessResult<ResetPasswordResponsea>>());
expect((result as ApiSucessResult ).sucessResult, successResponse);
verify(mockAuthRepository.resetPassword(request)).called(1);
      });
  test("should return ApiFailedResult when retrurn Repo success",
          ()async{
        when(mockAuthRepository.resetPassword(request))
            .thenAnswer((_)async=>failureResponse);
        final result=await resetPasswordUseCase.resetPassword(request);
        expect(result, isA<ApiFailedResult<ResetPasswordResponsea>>());
        expect((result as ApiFailedResult ).errorMessage, failureResponse.errorMessage);
        verify(mockAuthRepository.resetPassword(request)).called(1);
      });
})  ;

}