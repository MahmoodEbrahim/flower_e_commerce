
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_events.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupViewModel extends Bloc<SignUpEvent, SignUpState> {
  final SignupUsecase _signupUsecase;

  SignupViewModel(this._signupUsecase) : super(SignUpState()) {
    on<CreateUserEvent>(_signup);
  }

  Future<void> _signup(CreateUserEvent event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _signupUsecase.signUp(event.userModel);
    switch (result) {
      case ApiSuccessResult<UserModel>():
        
        emit(state.copyWith(
            isLoading: false,
            userModel: result.data,
            errorMessage: null));

      case ApiErrorResult<UserModel>():
        emit(state.copyWith(
            isLoading: false,
            errorMessage: result.errorMessage,
            userModel: null));
    }
  }
}
