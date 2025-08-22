import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';

import 'verfiy_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void provideDummies(){
  provideDummy<ApiResult<ResetPasswordResponsea>>(
      ApiErrorResult<ResetPasswordResponsea>("error"));
}

void main() {
  // test('TODO: Implement tests for reset_password_use_case.dart', () {
  //   // TODO: Implement test
  // });
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
  final failureResponse=ApiErrorResult<ResetPasswordResponsea>("ERROR");
  test("should return ApiSuccessResult when retrurn Repo success",
      ()async{
when(mockAuthRepository.resetPassword(request))
    .thenAnswer((_)async=>ApiSuccessResult(successResponse));
final result=await resetPasswordUseCase.resetPassword(request);
expect(result, isA<ApiSuccessResult<ResetPasswordResponsea>>());
expect((result as ApiSuccessResult ).data, successResponse);
verify(mockAuthRepository.resetPassword(request)).called(1);
      });
  test("should return ApiErrorResult when retrurn Repo success",
          ()async{
        when(mockAuthRepository.resetPassword(request))
            .thenAnswer((_)async=>failureResponse);
        final result=await resetPasswordUseCase.resetPassword(request);
        expect(result, isA<ApiErrorResult<ResetPasswordResponsea>>());
        expect((result as ApiErrorResult ).errorMessage, failureResponse.errorMessage);
        verify(mockAuthRepository.resetPassword(request)).called(1);
      });
})  ;

}