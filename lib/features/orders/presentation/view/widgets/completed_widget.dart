import 'package:flower_e_commerce/features/orders/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/order_entity/orders_entity.dart';

class CompletedWidget extends StatelessWidget{
  List<OrdersEntity>orders;
  CompletedWidget({super.key,required this.orders});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) =>OrderCard(ordersentity: orders[index],), separatorBuilder:(context, index) => SizedBox(height: 16.h,), itemCount: orders.length);
  }
}