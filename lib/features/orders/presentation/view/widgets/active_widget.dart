import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';
import 'package:flower_e_commerce/features/orders/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveWidget extends StatelessWidget{
  List<OrdersEntity>orders;
  ActiveWidget({super.key,required this.orders});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) =>OrderCard(iscompleted: false,ordersentity: orders[index],), separatorBuilder:(context, index) => SizedBox(height: 16.h,), itemCount: orders.length);
  }
}