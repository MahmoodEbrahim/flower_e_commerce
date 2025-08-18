import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';

class ForgetPasswordStates extends Equatable{
final  bool isLoadingForgetPassword;
final String? errorMessage;
 ForgetPasswordResponse? response;
final  bool isLoadingVerfiyPassword;
final String? errorMessageVerfiyPassword;
VerfiyPasswordResponse? verfiyPasswordResponse;
  ForgetPasswordStates(
      {this.isLoadingForgetPassword=true,
        this.errorMessage,
        this.response,
        this.isLoadingVerfiyPassword=true,
        this.errorMessageVerfiyPassword,
        this.verfiyPasswordResponse,
      });
ForgetPasswordStates copyWith({
    bool? isLoadingForgetPassword,
   String? errorMessage,
  ForgetPasswordResponse? response,
    bool? isLoadingVerfiyPassword,
   String? errorMessageVerfiyPassword,
  VerfiyPasswordResponse? verfiyPasswordResponse,
}){
  return ForgetPasswordStates(
    isLoadingForgetPassword: isLoadingForgetPassword??this.isLoadingForgetPassword,
    errorMessage: errorMessage??this.errorMessage,
    response: response??this.response,
    isLoadingVerfiyPassword: isLoadingVerfiyPassword??this.isLoadingVerfiyPassword,
    verfiyPasswordResponse: verfiyPasswordResponse??this.verfiyPasswordResponse,
      errorMessageVerfiyPassword: errorMessageVerfiyPassword??this.errorMessageVerfiyPassword
  );
}
  @override
  // TODO: implement props
  List<Object?> get props =>[
    isLoadingForgetPassword,
    errorMessage,
    response,
    isLoadingVerfiyPassword,verfiyPasswordResponse,errorMessageVerfiyPassword
  ];
}