import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/validator.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/reset_password_request.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/test_screen.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key,this.email});
  String? email;
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    var passwordController=TextEditingController();
    var formkey=GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>getIt<ForgetPasswordBCubit>(),
      child: Scaffold(
          backgroundColor: AppColors.White,
          appBar: AppBar(
            backgroundColor: AppColors.White,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20.sp,
                  color: AppColors.black[60]),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              local.password,
              style: getMediumStyle(color: AppColors.black,
                  fontSize: FontSize.s20),
            ),
          ),
          body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
            child:   Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(height: 26.h),
                  Text(
                    local.resetpassword,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: AppColors.black[50]!,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    local.passwordValidationMessage,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  SizedBox(height: 26.h),
                  CustomTxtFieldWidget(lbl: local.newpassword,
                    isPass: true,
                    hint: local.enteryoupassword,
                    controller: passwordController,
                    validator: Validator.validatePassword,),
                  SizedBox(height: 16.h),
                  CustomTxtFieldWidget(lbl: local.confirmpassword,
                    hint: local.confirmpassword,
                    isPass: true,

                    validator:(value)=> Validator.validateConfirmPassword(value,
                        passwordController!.text),),
                  SizedBox(height: 36.h),
                  BlocListener<ForgetPasswordBCubit,ForgetPasswordStates>
                    (listener: (c,state){
                    if(state.resetPasswordResponse!=null){
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    }}, child:Builder(builder: (c)=> CustomBtnWidget(txt: local.confirm,
                    onPressed: (){
                      if(formkey.currentState!.validate()){
                        c.read<ForgetPasswordBCubit>().resetPassword(
                            ResetPasswordRequest(
                                email:email!,
                                newPassword: passwordController.text
                            ));
                      }
                    },))

                  )],
              ),
            ),
          )

      ),
    );
  }
}