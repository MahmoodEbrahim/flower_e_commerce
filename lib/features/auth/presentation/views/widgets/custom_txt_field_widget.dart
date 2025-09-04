import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

class CustomTxtFieldWidget extends StatelessWidget {

     bool isPass;
  bool isSuffix;
  CustomTxtFieldWidget(
      {super.key,
      required this.lbl,
      required this.hint,
      this.validator,
      this.controller
      ,this.isPass=false,
        this.isSuffix=false
      });
  final String lbl;
  final String hint;
  
 

  TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
obscuringCharacter: "*",


      validator: validator,
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        suffixIcon:isSuffix?
      GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(AppRoutes.changePassword);
        },
        child: Align(
          alignment: Alignment.centerRight,
          child:   Text("Change   ",style: getMediumStyle(color: AppColors.Pink),),),
      ):null,
          label: Text(
            lbl,
            style:
                getRegularStyle(color: AppColors.gray, fontSize: FontSize.s12),
          ),
          hintText: hint,
          hintStyle:
              getRegularStyle(color: AppColors.gray, fontSize: FontSize.s14)),
    );
  }
}
