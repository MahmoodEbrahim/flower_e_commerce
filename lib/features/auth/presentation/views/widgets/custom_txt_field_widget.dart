import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTxtFieldWidget extends StatelessWidget {
   CustomTxtFieldWidget({super.key,required this.lbl,
   required this.hint,this.validator,this.controller});
final String lbl;
 final String hint;
   TextEditingController? controller;
 String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
color: AppColors.gray,width: 1.5.w
          ),
          borderRadius: BorderRadius.circular(4.r)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.red,width: 1.5.w
            ),
            borderRadius: BorderRadius.circular(4.r)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.red,width: 1.5.w
            ),
            borderRadius: BorderRadius.circular(4.r)
        ),

        disabledBorder: OutlineInputBorder(

            borderSide: BorderSide(
                color: AppColors.gray,width: 1.5.w
            ),
            borderRadius: BorderRadius.circular(4.r)
        )  ,
        enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.gray,width: 1.5.w
            ),
            borderRadius: BorderRadius.circular(4.r)
        )  ,
        focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.pink,width: 1.5.w
            ),
            borderRadius: BorderRadius.circular(4.r)
        ) ,
        label: Text(lbl,style: getRegularStyle(color: AppColors.gray,
            fontSize: FontSize.s12),)
,hintText:   hint,

        hintStyle: getRegularStyle(color: AppColors.gray,fontSize: FontSize.s14)

      ),

    );
  }
}
