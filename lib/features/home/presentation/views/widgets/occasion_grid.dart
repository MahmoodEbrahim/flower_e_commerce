import 'package:flower_e_commerce/config/theme/common_widgets/custom_flower_card.dart';
import 'package:flutter/cupertino.dart';

class OccasionGrid extends StatelessWidget {
  const OccasionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 163/240
    ), itemBuilder: (context,index){
      return CustomCardFlower();
    });
  }
}
