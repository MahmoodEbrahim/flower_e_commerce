import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/details_section.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/image_cart.dart';
import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  const CardSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       itemCount: 1,
       itemBuilder: (context, index) {
         return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
           padding: EdgeInsets.all( 5),
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               border: BoxBorder.all(color: AppColors.black[20]!)),
           width: double.infinity,
           child: 
           Row(
             children: [
               CardImage(),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: 
                   DetailsSection(),
                 
                 
                 ),
               )
             ],
           ),
                   
                   
         );
       });
  }
}

