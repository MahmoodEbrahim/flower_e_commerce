import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/utils/validator.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/features/auth/api/models/forget_password/request/forget_password_request.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/forget_password/forget_password_states.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/pages/verfiy_password.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme/font_style_manger.dart';
import '../../../../../core/l10n/translations/app_localizations.dart' ;
class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
var local=AppLocalizations.of(context)!;
var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();

    return   BlocProvider(create: (context)=>getIt
        .get<ForgetPasswordBCubit>(),
    child:    Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        leading: Icon(Icons.arrow_back_ios,size: 20.sp,color: AppColors.black[60],),

        title: Text(local.password,style: getMediumStyle
          (color: AppColors.black,fontSize: FontSize.s20,),
        ),),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24),


        child:Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 26.h,),
              Text(local.forgetpassword,textAlign: TextAlign.center,
                style: getMediumStyle(color: AppColors.black[50]!,
                    fontSize: FontSize.s18),),
              SizedBox(height: 16.h,),
              Text(local.pleaseenteryouremailassociatedtoyouraccount,textAlign: TextAlign.center,
                style: getMediumStyle(color: AppColors.gray,fontSize: FontSize.s14),),
              SizedBox(height: 26.h,),
              CustomTxtFieldWidget(lbl: local.email,

                validator: Validator.validateEmail
                ,hint: local.email,
                controller: emailController,
              ),
              SizedBox(height: 40.h,),
              BlocConsumer<ForgetPasswordBCubit,ForgetPasswordStates>(
                builder:  (context,state){
               return   CustomBtnWidget(txt: local.confirm,onPressed: (){
                 if(formKey.currentState!.validate()){
                   context.read<ForgetPasswordBCubit>().forgetPassword(
                     ForgetPasswordRequest(email: emailController.text),
                   );
                 }
               },);
                } ,
                listener: (context,state){
if(state.response?.message=="success"){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(local.passwordresetlinksentsuccessfully)),
  );
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VerfiyPasswordPage(

  email: emailController.text,
)));
}
if(state.errorMessage!=null){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text(local.emailnotfound)),
  );
}
                },

              )
            ],
          ),
        ),
      ),



    )
    );


  }
}
