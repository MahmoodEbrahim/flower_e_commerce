import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';

class ChangePasswordStates extends Equatable{
final  RequestState requestState;
final String errorMessage;
final ChangePasswordResponse? changePasswordResponse;
const ChangePasswordStates({
  this.requestState=RequestState.loading,
  this.changePasswordResponse,
  this.errorMessage=""
});
ChangePasswordStates copyWith({
    RequestState? requestState,
   String? errorMessage,
   ChangePasswordResponse? changePasswordResponse,
}){
  return ChangePasswordStates(
  requestState: requestState??this.requestState,
    changePasswordResponse: changePasswordResponse??this.changePasswordResponse,
    errorMessage: errorMessage??this.errorMessage
  );
}
  @override
  List<Object?> get props => [
requestState,errorMessage,changePasswordResponse
  ];
}