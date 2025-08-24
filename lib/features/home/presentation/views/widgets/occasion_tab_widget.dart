import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/cupertino.dart';

class occasionTab extends StatelessWidget {
  const  occasionTab({ super.key,required this.title,this.isSelected=false});
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return isSelected==false?
    Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: getRegularStyle(
            color: AppColors.midGray,
            fontSize: 20.0,

          ).copyWith(
              height: 2.1
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: -12,
          child: Container(
            height: 15.2,

            color: AppColors.midGray,
          ),
        ),
      ],
    ):
    Text(title,

      style: getRegularStyle(color:isSelected?
      AppColors.Pink:AppColors.midGray,
          fontSize: 20.0).copyWith(
          height: 2
      ),);
  }
}