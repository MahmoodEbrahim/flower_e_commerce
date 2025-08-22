import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerfiyPasswordPage extends StatefulWidget {
  VerfiyPasswordPage({this.email});
  final String? email;

  @override
  State<VerfiyPasswordPage> createState() => _VerfiyPasswordPageState();
}

class _VerfiyPasswordPageState extends State<VerfiyPasswordPage> {
  bool isButtonEnabled = true;
  bool isLoading = false;

  Future<void> _resendCode(BuildContext context) async {
    if (isButtonEnabled && !isLoading) {
      setState(() {
        isButtonEnabled = false;
        isLoading = true;
      });

      await context.read<ForgetPasswordBCubit>().forgetPassword(
            ForgetPasswordRequest(email: widget.email ?? ''),
          );

      Future.delayed(Duration(seconds: 30), () {
        setState(() {
          isButtonEnabled = true;
        });
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    print("email ${widget.email}");
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordBCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          backgroundColor: AppColors.White,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.black[60]),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            local.password,
            style:
                getMediumStyle(color: AppColors.black, fontSize: FontSize.s20),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 26.h),
              Text(
                local.forgetPassword,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: AppColors.black[50]!,
                  fontSize: FontSize.s18,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                local.pleaseEnterYourCodeThatSentToYourEmailAddress,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: AppColors.gray,
                  fontSize: FontSize.s14,
                ),
              ),
              SizedBox(height: 26.h),
              BlocListener<ForgetPasswordBCubit, ForgetPasswordStates>(
                  listener: (context, state) {
                    if (state.verfiyPasswordResponse != null &&
                        isButtonEnabled == true) {
                      Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                    }

                    if (state.errorMessageVerfiyPassword != null) {
                      SnackBar(
                          content:
                              Text("❌ ${state.errorMessageVerfiyPassword}"));
                    }
                  },
                  child:

                      // Builder(
                      //   builder: (c) => OtpTextField(
                      //     numberOfFields: 6,
                      //     fillColor: AppColors.lightGray,
                      //     enabledBorderColor: AppColors.lightGray,
                      //     cursorColor: AppColors.lightGray,
                      //     focusedBorderColor: AppColors.lightGray,
                      //     keyboardType: TextInputType.number,
                      //     filled: true,
                      //     textStyle: getMediumStyle(
                      //       color: Colors.black,
                      //       fontSize: FontSize.s12,
                      //     ),
                      //     borderColor: AppColors.lightGray,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //     onSubmit: (value) {
                      //       c.read<ForgetPasswordBCubit>().verfiyPassword(
                      //         VerfiyPasswordRequest(resetCode: value),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Builder(
                    builder: (c) => PinCodeTextField(
                      appContext: c, // Pass the context from Builder
                      length: 6, // Number of fields
                      obscureText: false, // No masking
                      keyboardType: TextInputType.number, // Numeric keyboard
                      enableActiveFill: true, // Enable fill color
                      animationType: AnimationType.fade, // Animation for input
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: getMediumStyle(
                        color: Colors.black,
                        fontSize: FontSize.s12,
                      ),
                      pinTheme: PinTheme(
                        
                        shape: PinCodeFieldShape.box, // Box shape for fields
                        borderRadius: BorderRadius.circular(10), // Match your border radius
                        fieldHeight: 50, // Adjust height as needed
                        fieldWidth: 50, // Adjust width as needed
                        activeColor:
                            AppColors.lightGray, // Border color when focused
                        inactiveColor: AppColors
                            .lightGray, // Border color when not focused
                        selectedColor:
                            AppColors.lightGray, // Border color when selected
                        activeFillColor:
                            AppColors.lightGray, // Fill color when active
                        inactiveFillColor:
                            AppColors.lightGray, // Fill color when inactive
                        selectedFillColor:
                            AppColors.lightGray, // Fill color when selected
                        borderWidth: 1, // Adjust border width if needed
                      ),
                      cursorColor: AppColors.lightGray, // Cursor color
                      onCompleted: (value) {
                        c.read<ForgetPasswordBCubit>().verfiyPassword(
                              VerfiyPasswordRequest(resetCode: value),
                            );
                      },
                      onChanged: (value) {
                        // Optional: Handle text changes if needed
                      },
                    ),
                  )),
              SizedBox(height: 26.h),
              BlocListener<ForgetPasswordBCubit, ForgetPasswordStates>(
                listener: (context, state) {
                  if (state.response != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reset Code Sent successfuly ')),
                    );
                  } else if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      local.didntReceiveCode,
                      style: getRegularStyle(
                        color: AppColors.black,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Builder(
                      builder: (c) => GestureDetector(
                        onTap: isButtonEnabled && !isLoading
                            ? () => _resendCode(c)
                            : null,
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.Pink,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Text(
                                local.resend,
                                style: TextStyle(
                                  fontSize: FontSize.s16,
                                  color: isButtonEnabled
                                      ? AppColors.Pink
                                      : AppColors.gray,
                                  decoration: TextDecoration.underline,
                                  decorationColor: isButtonEnabled
                                      ? AppColors.Pink
                                      : AppColors.gray,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
