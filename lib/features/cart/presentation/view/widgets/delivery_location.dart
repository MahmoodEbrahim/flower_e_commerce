import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Icon(Icons.location_on_outlined)),
        Expanded(
          flex: 18,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis, 
            text: TextSpan(
              text: "Deliver to ",
              style: getRegularStyle(color: AppColors.Black,fontSize: FontSize.s14),
              children: [
                TextSpan(
                  text:
                      " 2XVP+XC - Sheikh Zayed 2XVP+XC - Sheikh Zayed 2XVP+XC - Sheikh Zayed",
                  style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down,)))
      ],
    );
  }
}
