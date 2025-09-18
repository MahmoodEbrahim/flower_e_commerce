import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/core/utils/validator.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_state.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_event.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/change_password_view_model/change_password_states.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_e_commerce/core/di/di.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var currentPasswordController = TextEditingController();
    var newPassword = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<ChangePasswordBloc>(),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 24.0,
                  color: AppColors.blackColor[60],
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                local.resetpassword,
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: FontSize.s20,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    CustomTxtFieldWidget(
                      isPass: true,
                      controller: currentPasswordController,
                      validator: Validator.validatePassword,
                      lbl: local.currentPassword,
                      hint: local.currentPassword,
                    ),
                    SizedBox(height: 20.h),
                    CustomTxtFieldWidget(
                      isPass: true,
                      controller: newPassword,
                      validator: Validator.validatePassword,
                      lbl: local.newpassword,
                      hint: local.newpassword,
                    ),
                    SizedBox(height: 20.h),
                    CustomTxtFieldWidget(
                      isPass: true,
                      lbl: local.confirmpassword,
                      validator: (value) => Validator.validateConfirmPassword( value, newPassword.text, ),
                      hint: local.confirmpassword,
                    ),
                    SizedBox(height: 30.h),
                    BlocBuilder<UserSessionBloc, UserSessionState>(
                      builder: (context, sessionState) {
                        final token = sessionState.token;
                        return CustomBtnWidget(
                          txt: local.update,
                          bg: AppColors.blackColor[30]!,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (token != null && token.isNotEmpty) {
                                context.read<ChangePasswordBloc>().add(
                                  GetChangePasswordEvent(
                                    changePasswordRequest: ChangePasswordRequest(
                                      password: currentPasswordController.text.trim(),
                                      newPassword: newPassword.text.trim(),
                                    ),
                                    token: token,
                                  ),
                                );
                              } else {
                                // لو مش موجود التوكن
                                Navigator.of(context).pushNamed(AppRoutes.login);
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state.requestState == RequestState.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(local.passwordChangeSuccessfuly)),
            );
            Navigator.of(context).pushNamed(AppRoutes.login);
          } else if (state.requestState == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
      ),
    );
  }
}
