import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/order_items_entity.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../cart/presentation/view/widgets/image_cart.dart';

class OrderCard extends  StatelessWidget{
  bool iscompleted;
  OrdersEntity  ordersentity;
  OrderCard({super.key, this.iscompleted=true, required this.ordersentity});
  @override
  Widget build(BuildContext context) {


     return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: AppColors.blackColor[20]!)),
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              CardImage(
                productImage: ordersentity!.orderItems!=null&&ordersentity!.orderItems!.isNotEmpty?ordersentity!.orderItems!.first.product!.images!=null&&ordersentity!.orderItems!.first.product!.images!.isNotEmpty?ordersentity!.orderItems!.first.product!.images!.first:"https://i.stack.imgur.com/l60Hf.png":"https://i.stack.imgur.com/l60Hf.png",
              ),
              Expanded(child:Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ordersentity!.orderItems!.first.product!.title!,style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 12)),
                  SizedBox(height: 5,),
                  Text("${ordersentity.totalPrice.toString()}",style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 14,fontWeight: FontWeight.w500)),
                  SizedBox(height: 5,),
                  Text(ordersentity.Id.toString(),style: TextTheme.of(context).bodyMedium?.copyWith(fontSize: 12)),
                  SizedBox(height: 5,),
                  ElevatedButton(onPressed: (){}, child: Text(iscompleted?AppLocalizations.of(context)!.reorder:AppLocalizations.of(context)!.trackorder))
                ],
             ) )
            ],
          ),
        ),
      ),
    );
  }

}