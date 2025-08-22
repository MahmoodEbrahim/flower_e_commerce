import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/verfiy_password_use_case.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordBCubit extends Cubit<ForgetPasswordStates>{
  ForgetPasswordBCubit(this._forgetPasswordUseCase,this._resetPasswordUseCase,
      this._verfiyPasswordUseCase):super(ForgetPasswordStates());
  ForgetPasswordUseCase _forgetPasswordUseCase;
  VerfiyPasswordUseCase _verfiyPasswordUseCase;
  ResetPasswordUseCase _resetPasswordUseCase;
Future<void>forgetPassword(ForgetPasswordRequest request)async{
  emit(state.copyWith(isLoadingForgetPassword: true));
  final result=await _forgetPasswordUseCase.forgetPassword(request);
  switch(result){
    case ApiSuccessResult<ForgetPasswordResponse>():
    emit(state.copyWith(
      isLoadingForgetPassword: false,
      response: result.data
    ));
    case ApiErrorResult<ForgetPasswordResponse>():
      emit(state.copyWith(
          isLoadingForgetPassword: false,
          errorMessage: result.errorMessage
      ));
  }
}
  Future<void>verfiyPassword(VerfiyPasswordRequest request)async{
    emit(state.copyWith(isLoadingVerfiyPassword: true));
    final result=await _verfiyPasswordUseCase.verfiyPassword(request);
switch(result){
  case ApiSuccessResult<VerfiyPasswordResponse>():
    emit(state.copyWith(
        isLoadingForgetPassword: false,
        verfiyPasswordResponse: result.data
    ));
  case ApiErrorResult<VerfiyPasswordResponse>():
    emit(state.copyWith(
        isLoadingVerfiyPassword: false,
        errorMessageVerfiyPassword: result.errorMessage
    ));
}
}
  Future<void>
  resetPassword(ResetPasswordRequest request)async{
    final result=await _resetPasswordUseCase.resetPassword(request);
    switch(result){
      case ApiSuccessResult<ResetPasswordResponsea>():
        emit(state.copyWith(
            isLoadingResetPassword: false,
            resetPasswordResponse: result.data
        ));
      case ApiErrorResult<ResetPasswordResponsea>():
        emit(state.copyWith(
            isLoadingResetPassword: false,
            errorMessageResetPassword: result.errorMessage
        ));
    }
  }

  }
