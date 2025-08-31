import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text("Red roses",style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16),),
            IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon:
                    Icon(Icons.delete_outline_rounded,color: AppColors.red,))
          ],
        ),
        
        Text("15 Pink Rose Bouquent"),
    
        SizedBox(height: 20,),
        
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text("EGP 600",style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16),),
            Row(
              children: [
    
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons
                        .remove)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text("1",style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16),),
                ),
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
     
      ],
    );
  }
}
