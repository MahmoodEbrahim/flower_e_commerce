
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/custum_time_line.dart';
import 'package:flutter/material.dart';

class TimeLineList extends StatelessWidget {
  const TimeLineList({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustumTimeLine(
          isFirst: true,
          color: count >= 1 ? AppColors.pink : AppColors.gray,
        ),
        CustumTimeLine(
          color: count >= 2 ? AppColors.pink : AppColors.gray,
        ),
        CustumTimeLine(
          color: count >= 3 ? AppColors.pink : AppColors.gray,
        ),
        CustumTimeLine(
          isLast: true,
          color: count >= 4 ? AppColors.pink : AppColors.gray,
        ),
      ],
    );
  }
}
