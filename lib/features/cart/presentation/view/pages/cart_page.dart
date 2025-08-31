import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/card_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/delivery_location.dart';

import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.White,
        title: Text("Cart"),
        titleSpacing: 0,
        scrolledUnderElevation: 0,
        
        leading: IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: Navigator.of(context).pop,
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
        child: Column(
          children: [
            DeliveryLocation(),
            SizedBox(
              height: 400,
              child: CardSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
              child: SizedBox(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub Total"),
                      Text("100\$"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Fee"),
                      Text("10\$"),
                    ],
                  ),
                  Divider(
                    color: AppColors.black[20]!,
                    thickness: 1,
                   
                  ),


                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16)),
                      Text("110\$",style: getBoldStyle(color: AppColors.Black,fontSize: FontSize.s16),),
                    ],
                  ),
                ],
              )),
            )
         
         ,

           Row(
             children: [
               Expanded(child: ElevatedButton(
                onPressed: (){}, 
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("CheckOut",style: getRegularStyle(color: AppColors.White,fontSize: FontSize.s16),),
                ))),
             ],
           ),
         
          ],
        ),
      ),
    );
  }
}
