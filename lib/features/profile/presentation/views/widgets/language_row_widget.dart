import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageRow extends StatelessWidget {
  final String title;
  final String value;
  final String selected;
  final void Function(String?) onChanged;
  const LanguageRow({
    super.key,
    required this.title,
    required this.onChanged,
    required this.selected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextTheme.of(context).titleMedium,),
          Radio<String>(
            activeColor: AppColors.pink,
            fillColor: WidgetStateColor.resolveWith((states) => AppColors.pink),
            focusColor:AppColors.pink ,
            overlayColor: WidgetStateColor.resolveWith((states) => AppColors.pink),
            value: value,
            groupValue: selected,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

}