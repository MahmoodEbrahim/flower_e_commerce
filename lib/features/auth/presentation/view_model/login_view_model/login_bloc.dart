import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(loginState: RequestState.init));

      ApiResult<LoginModel> result =
          await loginUsecase(event.email, event.password);
      switch (result) {
        case ApiSucessResult<LoginModel>():
          emit(state.copyWith(
            loginState: RequestState.success,
            user: result.sucessResult,
          ));
          await UserLocalStorage.saveToken(result.sucessResult.token!);
          await UserLocalStorage.saveUser(result.sucessResult,);

          if (state.rememberMe) {
            await UserLocalStorage.saveUser(result.sucessResult);
          }

        case ApiFailedResult<LoginModel>():
          emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: result.errorMessage,
          ));
      }
    });

    on<ToggleRememberMe>(
      (event, emit) {
        emit(state.copyWith(rememberMe: event.value));
      },
    );
  }
}
