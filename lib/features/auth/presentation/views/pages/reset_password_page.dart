import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/config/utils/validator.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    var passwordController=TextEditingController();
    var emailController=TextEditingController();

    return Scaffold(
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
      child:   Column(
        children: [
          SizedBox(height: 26.h),
          Text(
            local.resetpassword, // ✅ camelCase
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
          CustomTxtFieldWidget(lbl: local.email,
            hint: local.enteryouremail,controller: emailController,
            validator: Validator.validateEmail,),
          SizedBox(height: 16.h),
          CustomTxtFieldWidget(lbl: local.newpassword,
            hint: local.enteryoupassword,controller: passwordController,
            validator: Validator.validatePassword,),
          SizedBox(height: 36.h),
          CustomBtnWidget(txt: local.confirm,onPressed: (){

          },)
        ],
      ),
      )

    );
  }
}
