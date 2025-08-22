import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/verfiy_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_case_test.mocks.dart';
void provideDummies(){
  provideDummy<ApiResult<VerfiyPasswordResponse>>(ApiErrorResult<VerfiyPasswordResponse>("error"));
}
@GenerateMocks([AuthRepository])
void main() {
  test('TODO: Implement tests for verfiy_password_use_case.dart', () {
    // TODO: Implement test
  });
late MockAuthRepository mockAuthRepository;
late VerfiyPasswordUseCase verfiyPasswordUseCase;
setUp((){
  provideDummies();

  mockAuthRepository=MockAuthRepository();
  verfiyPasswordUseCase=
      VerfiyPasswordUseCase(mockAuthRepository);
});
  group("VerfiyPasswordUseCase", (){
VerfiyPasswordRequest request=  VerfiyPasswordRequest();
VerfiyPasswordResponse successResponse=
VerfiyPasswordResponse(status: "success");
final failureResponse=
ApiErrorResult<VerfiyPasswordResponse>
  ("Reset code is invalid or has expired");
test("should call ApiSucessResult when repo return success",
        ()async{
      when(mockAuthRepository.verfiyPassword(request)).thenAnswer((_)async=>
          ApiSuccessResult(successResponse));
      final result=await verfiyPasswordUseCase.verfiyPassword(request);
      expect(result, isA<ApiSuccessResult<VerfiyPasswordResponse>>());
      expect((result as ApiSuccessResult).data, successResponse);
      verify(mockAuthRepository.verfiyPassword(request)).called(1);
    });
test("should call ApiFailedResult when repo return failure", ()async{
  when(mockAuthRepository.verfiyPassword(request))
      .thenAnswer((_)async=>failureResponse);
  final result=await verfiyPasswordUseCase.verfiyPassword(request);
  expect(result, isA<ApiErrorResult<VerfiyPasswordResponse>>());
  expect((result as ApiErrorResult).errorMessage, failureResponse.errorMessage);
  verify(mockAuthRepository.verfiyPassword(request)).called(1);
  
});
  });


}