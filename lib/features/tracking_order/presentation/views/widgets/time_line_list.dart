import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/helpers/order_data_helper.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/custum_time_line.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/views/widgets/text_section.dart';
import 'package:flutter/material.dart';

class TimeLineList extends StatefulWidget {
  final String orderId;
  final int count;
  const TimeLineList({super.key, required this.count, required this.orderId});

  @override
  State<TimeLineList> createState() => _TimeLineListState();
}

class _TimeLineListState extends State<TimeLineList> {
  final OrderDateHelper orderDateHelper = getIt.get<OrderDateHelper>();
  List<String> dates = List.filled(4, "");

  @override
  void initState() {
    _loadDates();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TimeLineList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.count != oldWidget.count && widget.count <= 4)) {
      orderDateHelper.addOrderDate(widget.orderId);
      _loadDates();
    }
  }

  Future<void> _loadDates() async {
    List<String> savedDates = await orderDateHelper.getOrderDates(widget.orderId);
    if (savedDates.isEmpty) {
      orderDateHelper.addOrderDate(widget.orderId);
      savedDates = await orderDateHelper.getOrderDates(widget.orderId);
    }
    setState(() {
      for (int i = 0; i < savedDates.length && i < 4; i++) {
        dates[i] = savedDates[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final steps = [
      t.receivedYourOrder,
      t.preparingYourOrder,
      t.outForDelivery,
      t.delivered,
    ];

    return ListView.builder(
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return CustumTimeLine(
          isFirst: index == 0,
          isLast: index == steps.length - 1,
          color: widget.count >= index + 1 ? AppColors.pink : AppColors.gray,
          endChildWidget: TextSection(
            txt1: steps[index],
            txt2: dates[index],
            style1: getBoldStyle(
              color: AppColors.black,
              fontSize: FontSize.s14,
            ).copyWith(letterSpacing: 1),
            style2: getMediumStyle(
              color: AppColors.gray,
              fontSize: FontSize.s14,
            ),
          ),
        );
      },
    );
  }
}
