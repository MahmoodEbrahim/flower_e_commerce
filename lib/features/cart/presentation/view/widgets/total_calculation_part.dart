import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

class TotalCalculationPart extends StatelessWidget {
  final int price;

  const TotalCalculationPart({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    int delivery = 10;
    bool isPriceEqualZero = false;
    if (price == 0) {
      isPriceEqualZero = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: SizedBox(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sub Total"),
              Text("$price\$"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Fee"),
              Text("$delivery\$"),
            ],
          ),
          Divider(
            color: AppColors.black[20]!,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",
                  style: getBoldStyle(
                      color: AppColors.Black, fontSize: FontSize.s16)),
              Text(
                isPriceEqualZero?'0 \$':'${price+delivery} \$',
                style: getBoldStyle(
                    color: AppColors.Black, fontSize: FontSize.s16),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
