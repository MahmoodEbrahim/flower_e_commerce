import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtnWidget extends StatelessWidget {
   CustomBtnWidget({super.key,required this.txt,this.onPressed});
  void Function()?onPressed;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r)
          ),
          backgroundColor: AppColors.Pink,
          foregroundColor: AppColors.White,
          fixedSize: Size(double.infinity, 48.h),
          
        ),
        onPressed: onPressed, child: Center(child: Text(txt),));
  }
}
