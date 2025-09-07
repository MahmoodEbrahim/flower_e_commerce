import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:   AppBar(
title: Text("Saved Address",style: getMediumStyle(color: AppColors.black,
    fontSize:20.sp ),),
        leading: IconButton(onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
    );
  }
}
