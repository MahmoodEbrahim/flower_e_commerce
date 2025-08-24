import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_grid.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_tab_widget.dart';
import 'package:flutter/material.dart';

class OccasionPage extends StatefulWidget {
  const OccasionPage({super.key});

  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {
  int currIndex=0;
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context);
    return Scaffold(

      backgroundColor: AppColors.White,
      body: SafeArea(child:
     Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
       child:  Column(
       children: [
         Row(
           children: [
             SizedBox(height: 10.0,),
             Row(
               children: [
                 Icon(Icons.arrow_back_ios_new,size:
                 28.0,color: AppColors.lightBlack,),
                 SizedBox(width: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(local!.occasion,style: getMediumStyle(color: AppColors.lightBlack,
                      fontSize: 20.0),),

                  Text(local.bloomWithOurExquisitebestSellers,
                    style: getMediumStyle(color: AppColors.white[90]!,
                      fontSize: 13.0),),

                ],
              )

               ],
             )
           ],
         ),
         SizedBox(height: 10.0,),
         DefaultTabController(length: 10,
          child: TabBar(
onTap: (index){
  currIndex=index;
  setState(() {

  });
},
              indicatorColor: AppColors.Pink,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
indicatorWeight: 2,

dividerColor: Colors.transparent,


indicatorPadding: EdgeInsets.only(
),
              padding: EdgeInsets.zero,

              tabs: List.generate(10, (index)=>occasionTab(
                  title: "Weeding $index",
                isSelected: index==currIndex,))),),
         SizedBox(height: 16.0,),
         Expanded(child: OccasionGrid())
       ],
     ),),)
    );
  }
}

