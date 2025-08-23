import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/repository/auth_repository.dart';

import 'forget_password_use_case_test.mocks.dart';


@GenerateMocks([AuthRepository])

void provideDummies() {
  provideDummy<ApiResult<ForgetPasswordResponse>>(
    ApiErrorResult<ForgetPasswordResponse>('Dummy error'),
  );
}

void main() {

  late ForgetPasswordUseCase forgetPasswordUseCase;
  late MockAuthRepository mockAuthRepository;


  setUp(() {
    provideDummies();
    mockAuthRepository = MockAuthRepository();
    forgetPasswordUseCase = ForgetPasswordUseCase(mockAuthRepository);
  });

  group("Forget Password Usecase", (){
    ForgetPasswordRequest request=ForgetPasswordRequest();
    ForgetPasswordResponse successResponse=ForgetPasswordResponse(
        message: "success",
        info: "OTP sent to your email"
    );
    final failureResponse=ApiErrorResult<ForgetPasswordResponse>("error");


    test("should call ApiSucessResult when repo return success ",
        ()async{
when(mockAuthRepository.forgetPassword(request))
    .thenAnswer((_)async=>ApiSuccessResult(successResponse));
final result=await forgetPasswordUseCase.forgetPassword(request);
expect(result, isA<ApiSuccessResult>());
expect((result as ApiSuccessResult).data, successResponse);
verify(mockAuthRepository.forgetPassword(request)).called(1);
        });
    test("should call ApiFailedResult when repo return success",
        ()async{
      when(mockAuthRepository.forgetPassword(request))
          .thenAnswer((_)async=>failureResponse);
      final result=await forgetPasswordUseCase.forgetPassword(request);
      expect(result, isA<ApiSuccessResult>());
      expect((result as ApiErrorResult).errorMessage, failureResponse);
      verify(mockAuthRepository.forgetPassword(request)).called(1);
        });
  });
}
