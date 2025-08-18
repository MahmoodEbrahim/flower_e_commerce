import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';

class ForgetPasswordStates extends Equatable{
final  bool isLoadingForgetPassword;
final String? errorMessage;
 ForgetPasswordResponse? response;

  ForgetPasswordStates(
      {this.isLoadingForgetPassword=true,
        this.errorMessage,
        this.response});
ForgetPasswordStates copyWith({
    bool? isLoadingForgetPassword,
   String? errorMessage,
  ForgetPasswordResponse? response
}){
  return ForgetPasswordStates(
    isLoadingForgetPassword: isLoadingForgetPassword??this.isLoadingForgetPassword,
    errorMessage: errorMessage??this.errorMessage,
    response: response??this.response
  );
}
  @override
  // TODO: implement props
  List<Object?> get props =>[
    isLoadingForgetPassword,
    errorMessage,
    response
  ];
}