import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_change_password_use_case.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_event.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ChangePasswordBloc extends Bloc<ChangePasswordEvent,ChangePasswordStates>{
  GetChangePasswordUseCase _getChangePasswordUseCase;
  ChangePasswordBloc(this._getChangePasswordUseCase):super(ChangePasswordStates()){
    on<GetChangePasswordEvent>((event,emit)async{
      emit(state.copyWith(
        requestState: RequestState.init
      ));
      final result=await _getChangePasswordUseCase.
      changePassword(event.changePasswordRequest, event.token);
      switch(result){
        case ApiSucessResult<ChangePasswordResponse>():
          emit(state.copyWith(
       requestState: RequestState.success,
       changePasswordResponse: result.sucessResult
          ));
          case ApiFailedResult<ChangePasswordResponse>():
          emit(state.copyWith(
            requestState: RequestState.error,
            errorMessage: result.errorMessage,
          ));
      }
    });
  }
}