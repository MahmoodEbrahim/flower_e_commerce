import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class DraagableLine extends StatelessWidget {
  const DraagableLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
    
        child: Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
