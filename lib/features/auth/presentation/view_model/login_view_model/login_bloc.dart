import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
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

      ApiResult<LoginEntity> result =
          await loginUsecase(event.email, event.password);
      switch (result) {
        case ApiSuccessResult<LoginEntity>():
          emit(state.copyWith(
            loginState: RequestState.success,
            user: result.data,
          ));

        case ApiErrorResult<LoginEntity>():
          emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: result.errorMessage,
          ));
      }
    });
  }
}
