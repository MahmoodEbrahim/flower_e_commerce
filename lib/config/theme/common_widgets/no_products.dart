import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 180.0,),
        Icon(CupertinoIcons.info_circle_fill,size: 60,color: AppColors.Pink,),
        SizedBox(height: 20.0,),
Text("No Products Found",
  style: getBoldStyle(color: AppColors.gray,fontSize: 20),)
      ],
    );
  }
}
