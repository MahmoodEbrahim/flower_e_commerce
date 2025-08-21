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

class VerfiyPasswordPage extends StatelessWidget {
  const VerfiyPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
var email=ModalRoute.of(context)!.settings!.arguments as String?;
print("email $email");
    return   BlocProvider(create: (context)=>getIt<ForgetPasswordBCubit>(),
      child:  Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.black[60]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          local.password,
          style: getMediumStyle(color: AppColors.black, fontSize: FontSize.s20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 26.h),
            Text(
              local.forgetpassword,
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
            BlocListener<ForgetPasswordBCubit,ForgetPasswordStates>(
              listener: (context,state){
                if(state.verfiyPasswordResponse!=null ){
                  Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                }
              },
              child: Builder(builder: (c)=>      OtpTextField(
                numberOfFields: 6,
                fillColor: AppColors.lightGray,
                enabledBorderColor: AppColors.lightGray,
                cursorColor: AppColors.lightGray,
                focusedBorderColor: AppColors.lightGray,
                keyboardType: TextInputType.number,
                filled: true,
                textStyle: getMediumStyle(
                  color: Colors.black,
                  fontSize: FontSize.s12,

                ),
                borderColor: AppColors.lightGray,
                borderRadius: BorderRadius.circular(10.r),
                onCodeChanged: (value) {
                  c.read<ForgetPasswordBCubit>().verfiyPassword(
                    VerfiyPasswordRequest(resetCode: value),
                  );
                },
                onSubmit: (value) {
                  c.read<ForgetPasswordBCubit>().verfiyPassword(
                    VerfiyPasswordRequest(resetCode: value),
                  );
                },
              ),)

             ),
            SizedBox(height: 26.h),
            Row(
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
            Builder(builder: (c){
              return     GestureDetector(
                onTap: (){
                  c.read<ForgetPasswordBCubit>().forgetPassword(
                      ForgetPasswordRequest(
                          email: email!
                      ));

                },
                child: Text(
                  local.resend,
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    color: AppColors.Pink,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.Pink,
                  ),
                ),
              );
            })
              ],
            ),
          ],
        ),
      ),

    ) ,);




  }
}
