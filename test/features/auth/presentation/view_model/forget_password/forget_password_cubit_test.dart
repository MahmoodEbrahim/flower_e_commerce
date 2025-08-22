import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/verfiy_password_use_case.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';
@GenerateMocks([ForgetPasswordUseCase,VerfiyPasswordUseCase,ResetPasswordUseCase])
provideDummies(){
  provideDummy<ApiResult<ForgetPasswordResponse>>(
    ApiErrorResult<ForgetPasswordResponse>( ' error'),
  );
  provideDummy<ApiResult<VerfiyPasswordResponse>>(
    ApiErrorResult<VerfiyPasswordResponse>( ' error'),
  );
  provideDummy<ApiResult<ResetPasswordResponsea>>(
    ApiErrorResult<ResetPasswordResponsea>( ' error'),
  );
}
void main() {
  late ForgetPasswordBCubit cubit;
  late ForgetPasswordUseCase forgetPasswordUseCase;
  late VerfiyPasswordUseCase verfiyPasswordUseCase;
  late ResetPasswordUseCase resetPasswordUseCase;

setUp((){
  provideDummies();
  forgetPasswordUseCase=MockForgetPasswordUseCase();
  verfiyPasswordUseCase=MockVerfiyPasswordUseCase();
  resetPasswordUseCase=MockResetPasswordUseCase();
  cubit=ForgetPasswordBCubit(forgetPasswordUseCase,
      resetPasswordUseCase, verfiyPasswordUseCase);
});
group("Forget Password Cubit", (){
  group("forget password", (){
    ForgetPasswordRequest request=ForgetPasswordRequest();
    ForgetPasswordResponse forgetPasswordResponse=ForgetPasswordResponse(
      message: "success"
    );
    blocTest<ForgetPasswordBCubit,ForgetPasswordStates>
      ("emits loading and success state when forgetPassword succeeds",
        build: (){
        when(forgetPasswordUseCase.forgetPassword(request)).
        thenAnswer((_)async=>ApiSuccessResult(forgetPasswordResponse));
        return cubit;
        },act:(cubit)=>cubit.forgetPassword(request) ,expect:()=>[
       ForgetPasswordStates(isLoadingForgetPassword: true),
          ForgetPasswordStates(isLoadingForgetPassword: false,
              response:forgetPasswordResponse )
        ] );
    blocTest<ForgetPasswordBCubit,ForgetPasswordStates>
      ("emits loading and fails state when forgetPassword failure", 
        build: (){
        when(forgetPasswordUseCase.forgetPassword(request))
            .thenAnswer((_)async=>ApiErrorResult('There is no account with this email address  mariammohme.25720@gmail.com'));
     return cubit;
        },act: (cubit)=>cubit.forgetPassword(request),
      expect: ()=>[
        ForgetPasswordStates(isLoadingForgetPassword: true),
ForgetPasswordStates(isLoadingForgetPassword: false,errorMessage: 'There is no account with this email address  mariammohme.25720@gmail.com')
      ]
        );

  });
  group("verify password", (){
    VerfiyPasswordRequest request=VerfiyPasswordRequest(
        resetCode:"200372"
    );
    final successResponse = VerfiyPasswordResponse(
        status: 'Success');
    blocTest<ForgetPasswordBCubit, ForgetPasswordStates>(
      "emits [loading, Success] when verfiyPassword succeeds",
      build: () {
        when( verfiyPasswordUseCase.verfiyPassword(request))
            .thenAnswer((_) async => ApiSuccessResult(successResponse));
        return cubit;
      },
      act:(cubit) => cubit.verfiyPassword(request),
      expect: () => [

        ForgetPasswordStates(
          isLoadingVerfiyPassword: true,
        ),
        ForgetPasswordStates(
          isLoadingVerfiyPassword: false,
          verfiyPasswordResponse: successResponse,
        ),
      ],
    );

    blocTest<ForgetPasswordBCubit,
        ForgetPasswordStates>(
        "emits loading and fails state when verifyPassword fails",
        build: (){
          when(verfiyPasswordUseCase.verfiyPassword(request))
              .thenAnswer((_)async=>ApiErrorResult("failed"));
          return cubit;
        },act: (cubit)=>cubit.verfiyPassword(request),
    expect: ()=>[
      ForgetPasswordStates(isLoadingVerfiyPassword: true),
      ForgetPasswordStates(isLoadingVerfiyPassword: false,
          errorMessageVerfiyPassword: 'failed')
    ]
    );

  });
  group("Reset Password", (){
    ResetPasswordRequest request=ResetPasswordRequest();
    final successResponse=ResetPasswordResponsea(
        message: "success",
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4Nzc2NGQ2NTU1NGIzMjg5MTJlNWQ0YiIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzU1Nzg0MzU4fQ.Ct5y62muHty0JdA12VIUTbECGBqRk2Tpja8LpBz3Drk"
    );
    blocTest<ForgetPasswordBCubit,ForgetPasswordStates>
      ("emits loading and success state when forgetPassword succeeds",
        build: (){
          when(resetPasswordUseCase.resetPassword(request)).
          thenAnswer((_)async=>ApiSuccessResult(successResponse));
          return cubit;
        },act:(cubit)=>cubit.resetPassword(request) ,expect:()=>[
          ForgetPasswordStates(isLoadingResetPassword: true),
          ForgetPasswordStates(isLoadingResetPassword: false,
              resetPasswordResponse:successResponse )
        ] );
    blocTest<ForgetPasswordBCubit,
        ForgetPasswordStates>(
        "emits loading and fails state when resetPassword fails",
        build: (){
          when(resetPasswordUseCase.resetPassword(request))
              .thenAnswer((_)async=>ApiErrorResult("reset code not verified"));
          return cubit;
        },act: (cubit)=>cubit.resetPassword(request),
        expect: ()=>[
          ForgetPasswordStates(isLoadingResetPassword: true),
          ForgetPasswordStates(isLoadingResetPassword: false,
              errorMessageResetPassword: 'reset code not verified')
        ]
    );
  });

});

}
