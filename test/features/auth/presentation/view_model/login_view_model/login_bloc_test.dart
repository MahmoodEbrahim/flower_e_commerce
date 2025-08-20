import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUsecase])
main() {
  provideDummy<ApiResult<LoginEntity>>(ApiErrorResult<LoginEntity>("dummy"));
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

  final fakeLoginEntity = LoginEntity(
    token: "fake_token",
    user: UserEntity(
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
      createdAt: "2025-08-20",
    ),
  );

  group(
    "test LoginButtonPressed ",
    () {
      blocTest<LoginBloc, LoginState>(
        "emits [init, success] when login succeeds",
        build: () {
          when(mockLoginUsecase.call(email, password)).thenAnswer(
              (_) async => ApiSuccessResult<LoginEntity>(fakeLoginEntity));
          return loginBloc;
        },
        act: (bloc) =>
            bloc.add(LoginButtonPressed(email: email, password: password)),
        expect: () => [
          LoginState(loginState: RequestState.init),
          LoginState(
            loginState: RequestState.success,
            user: fakeLoginEntity,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        "emits [init, error] when login succeeds",
        build: () {
          when(mockLoginUsecase.call(email, password)).thenAnswer(
              (_) async => ApiErrorResult<LoginEntity>("errorMessage"));
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
