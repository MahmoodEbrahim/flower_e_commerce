import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_change_password_use_case.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_event.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'change_password_bloc_test.mocks.dart';

@GenerateMocks([GetChangePasswordUseCase])

void main() {
  late MockGetChangePasswordUseCase mockGetChangePasswordUseCase;
  late ChangePasswordBloc changePasswordBloc;
  setUp((){
    mockGetChangePasswordUseCase=MockGetChangePasswordUseCase();
    changePasswordBloc=ChangePasswordBloc(mockGetChangePasswordUseCase);
    provideDummy<ApiResult<ChangePasswordResponse>>(
        ApiFailedResult<ChangePasswordResponse>("Dummy Error")
    );
  });
  group("ChangePassword Bloc", (){
    String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY";
    ChangePasswordRequest request=ChangePasswordRequest(
        password: "Mari123@",
        newPassword: "Mari123@1"
    );
    final successResponse=ChangePasswordResponse(
        message: "success",
        token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY"
    );
    blocTest<ChangePasswordBloc, ChangePasswordStates>(
        "emits loading, Success when changePassword succeeds",
        build: () {
          when(mockGetChangePasswordUseCase.changePassword(request, token)).
          thenAnswer((_)async=>ApiSucessResult(successResponse));
          return changePasswordBloc;
        },
        act:(bloc) =>bloc.add(GetChangePasswordEvent(
            changePasswordRequest: request, token: token)),
        expect: () => [
          ChangePasswordStates(requestState: RequestState.init),
          ChangePasswordStates(
              requestState: RequestState.success,
              changePasswordResponse: successResponse
          )

        ],
        verify: (_){
          verify(mockGetChangePasswordUseCase.changePassword(request, token)).called(1);
        }
    );
    final failureResponse=ChangePasswordResponse(message: "invalid token .. login again");
    blocTest<ChangePasswordBloc, ChangePasswordStates>

      (    "emits loading, Failure when changePassword succeeds",
        build: (){
      when(mockGetChangePasswordUseCase.changePassword(request, token)).thenAnswer((_)async=>
          ApiFailedResult<ChangePasswordResponse>(failureResponse.message!));
      return changePasswordBloc;
        },
    act: (bloc)=>bloc.add(GetChangePasswordEvent(changePasswordRequest: request,
        token: token)),expect: ()=>[
          ChangePasswordStates(requestState: RequestState.init),
          ChangePasswordStates(
              requestState: RequestState.error,
              errorMessage: failureResponse.message!
          )
        ],verify: (_){

    verify(mockGetChangePasswordUseCase.changePassword(request, token)).called(1);
        });

  });
}