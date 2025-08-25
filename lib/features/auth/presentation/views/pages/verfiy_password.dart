import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/verfiy_password_request.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerfiyPasswordPage extends StatefulWidget {
   VerfiyPasswordPage({this.email});
String? email;

  @override
  State<VerfiyPasswordPage> createState() => _VerfiyPasswordPageState();
}

class _VerfiyPasswordPageState extends State<VerfiyPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
        print("email ${widget.email}");
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>ResetPasswordPage(
                        email: widget.email,
                      )));
                }
                if(state.errorMessageVerfiyPassword!=null ){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:
                  Text(state.errorMessageVerfiyPassword!.toString()))
                );
                }
              },
              child:

              Builder(
                builder: (c) => PinCodeTextField(
                  appContext: c,
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: getMediumStyle(
                    color: Colors.black,
                    fontSize: FontSize.s12,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeColor:
                    AppColors.lightGray,
                    inactiveColor: AppColors
                        .lightGray,
                    selectedColor:
                    AppColors.lightGray,
                    activeFillColor:
                    AppColors.lightGray,
                    inactiveFillColor:
                    AppColors.lightGray,
                    selectedFillColor:
                    AppColors.lightGray,
                    borderWidth: 1,
                  ),
                  cursorColor: AppColors.lightGray, // Cursor color
                  onCompleted: (value) {

                    c.read<ForgetPasswordBCubit>().verfiyPassword(
                      VerfiyPasswordRequest(resetCode: value),
                    );
                  },
                  onChanged: (value) {
                  },
                ),
              )
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
                          email: widget.email!
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
