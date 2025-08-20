import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUsecase])
main() {
  provideDummy<ApiResult<LoginModel>>(ApiErrorResult<LoginModel>("dummy"));
  late LoginBloc loginBloc;
  late MockLoginUsecase mockLoginUsecase;

  setUp(
    () {
      mockLoginUsecase = MockLoginUsecase();
      loginBloc = LoginBloc(mockLoginUsecase);
    },
  );

  const email = "test@test.com";
  const password = "123456";

  final fakeLoginModel = LoginModel(
    token: "fake_token",
    user: UserModel(
      Id: "1",
      firstName: "Test",
      lastName: "User",
      email: email,
      gender: "female",
      phone: "0123456789",
      photo: null,
      role: "customer",
      wishlist: [],
      addresses: [],
    ),
  );

  group(
    "test LoginButtonPressed ",
    () {
      blocTest<LoginBloc, LoginState>(
        "emits [init, success] when login succeeds",
        build: () {
          when(mockLoginUsecase.call(email, password)).thenAnswer(
              (_) async => ApiSuccessResult<LoginModel>(fakeLoginModel));
          return loginBloc;
        },
        act: (bloc) =>
            bloc.add(LoginButtonPressed(email: email, password: password)),
        expect: () => [
          LoginState(loginState: RequestState.init),
          LoginState(
            loginState: RequestState.success,
            user: fakeLoginModel,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        "emits [init, error] when login succeeds",
        build: () {
          when(mockLoginUsecase.call(email, password)).thenAnswer(
              (_) async => ApiErrorResult<LoginModel>("errorMessage"));
          return loginBloc;
        },
        act: (bloc) =>
            bloc.add(LoginButtonPressed(email: email, password: password)),
        expect: () => [
          LoginState(loginState: RequestState.init),
          LoginState(
              loginState: RequestState.error, errorMessage: "errorMessage"),
        ],
      );
    },
  );

  group("test ToggleRememberMe", () {
    blocTest<LoginBloc, LoginState>(
      "emits [rememberMe: true] when ToggleRememberMe(true) is added",
      build: () => loginBloc,
      act: (bloc) => bloc.add(ToggleRememberMe(true)),
      expect: () => [
        LoginState(rememberMe: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      "emits [rememberMe: false] when ToggleRememberMe(false) is added",
      build: () => loginBloc,
      act: (bloc) => bloc.add(ToggleRememberMe(false)),
      expect: () => [
        LoginState(rememberMe: false),
      ],
    );

  },);
  

}
