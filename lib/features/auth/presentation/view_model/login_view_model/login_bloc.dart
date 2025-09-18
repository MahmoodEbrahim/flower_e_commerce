import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage_imp.dart';
import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import '../user_session_view_model/user_session_bloc.dart';
import 'login_event.dart';

part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final UserSessionBloc userSessionBloc;
  final UserLocalStorage userLocalStorage;

  LoginBloc(this.loginUsecase, this.userSessionBloc,this.userLocalStorage) : super(const LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(loginState: RequestState.loading));

      final ApiResult<LoginModel> result =
      await loginUsecase(event.email, event.password);

      switch (result.runtimeType) {
        case const (ApiSucessResult<LoginModel>):
          final loginModel = (result as ApiSucessResult<LoginModel>).sucessResult;
          print("login success");

          // حفظ الـ token لو rememberMe مفعل
          if (state.rememberMe) {
            await userLocalStorage.saveToken(loginModel.token);
          }

          // ارسال الحدث للـ UserSessionBloc
          userSessionBloc.add(UserLoggedIn(loginModel.token, loginModel.user));

          emit(state.copyWith(
            loginState: RequestState.success,
            user: loginModel,
          ));
          break;

        case const (ApiFailedResult<LoginModel>):
          final errorMessage = (result as ApiFailedResult<LoginModel>).errorMessage;
          emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: errorMessage,
          ));
          break;
      }
    });

    on<ToggleRememberMe>((event, emit) {
      emit(state.copyWith(rememberMe: event.value));
    });
  }
}
