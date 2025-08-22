import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

class CustomTxtFieldWidget extends StatelessWidget {

    final bool isPass;
  
  CustomTxtFieldWidget(
      {super.key,
      required this.lbl,
      required this.hint,
      this.validator,
      this.controller
      ,this.isPass=false
      });
  final String lbl;
  final String hint;
  
 

  TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
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
