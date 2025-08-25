import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/forget_password_response.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/reset_password_responsea.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/response/verfiy_password_response.dart';

class ForgetPasswordStates extends Equatable{
final  bool isLoadingForgetPassword;
final String? errorMessage;
 ForgetPasswordResponse? response;
final  bool isLoadingVerfiyPassword;
final String? errorMessageVerfiyPassword;
VerfiyPasswordResponse? verfiyPasswordResponse;
final  bool isLoadingResetPassword;
final String? errorMessageResetPassword;
ResetPasswordResponsea? resetPasswordResponse;
  ForgetPasswordStates(
      {this.isLoadingForgetPassword=true,
        this.errorMessage,
        this.response,
        this.isLoadingVerfiyPassword=true,
        this.errorMessageVerfiyPassword,
        this.verfiyPasswordResponse,
        this.isLoadingResetPassword=true,
        this.resetPasswordResponse,
        this.errorMessageResetPassword
      });
ForgetPasswordStates copyWith({
    bool? isLoadingForgetPassword,
   String? errorMessage,
  ForgetPasswordResponse? response,
    bool? isLoadingVerfiyPassword,
   String? errorMessageVerfiyPassword,
  VerfiyPasswordResponse? verfiyPasswordResponse,
    bool? isLoadingResetPassword,
   String? errorMessageResetPassword,
  ResetPasswordResponsea? resetPasswordResponse
}){
  return ForgetPasswordStates(
    isLoadingForgetPassword: isLoadingForgetPassword??this.isLoadingForgetPassword,
    errorMessage: errorMessage??this.errorMessage,
    response: response??this.response,
    isLoadingVerfiyPassword: isLoadingVerfiyPassword??this.isLoadingVerfiyPassword,
    verfiyPasswordResponse: verfiyPasswordResponse??this.verfiyPasswordResponse,
      errorMessageVerfiyPassword: errorMessageVerfiyPassword??this.errorMessageVerfiyPassword,
 isLoadingResetPassword:isLoadingResetPassword??this.isLoadingResetPassword ,
 resetPasswordResponse:resetPasswordResponse??this.resetPasswordResponse ,
 errorMessageResetPassword:errorMessageResetPassword??this.errorMessageResetPassword,

  );
}
  @override
  // TODO: implement props
  List<Object?> get props =>[
    isLoadingForgetPassword,
    errorMessage,
    response,
    isLoadingVerfiyPassword,
    verfiyPasswordResponse,
    errorMessageVerfiyPassword,
    isLoadingResetPassword,
    resetPasswordResponse,
    errorMessageResetPassword,

  ];
}