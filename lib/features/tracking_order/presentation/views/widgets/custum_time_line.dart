import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustumTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final Widget endChildWidget;

  final Color color;

  const CustumTimeLine({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.color, required this.endChildWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      endChild: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 15),
        child: endChildWidget
      ),

      indicatorStyle: IndicatorStyle(
        width: 25,
        height: 25,
        indicator: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color == AppColors.gray
                    ? Colors.transparent
                    : AppColors.pink,
              ),
            ),
          ),
        ),
      ),
      afterLineStyle: LineStyle(color: color, thickness: 1),
      beforeLineStyle: LineStyle(color: color, thickness: 1),
    );
  }
}
