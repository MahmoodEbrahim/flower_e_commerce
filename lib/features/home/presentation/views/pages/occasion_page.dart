import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
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
                  Text("Occasion",style: getMediumStyle(color: AppColors.lightBlack,
                      fontSize: 20.0),),

                  Text("Bloom with our exquisite best sellers",
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
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.only(
                  top:
                  20),
              padding: EdgeInsets.zero,

              tabs: List.generate(10, (index)=>occasionTab(
                  title: "Weeding $index",isSelected: index==currIndex,))),)
       ],
     ),),)
    );
  }
}
class occasionTab extends StatelessWidget {
 const  occasionTab({ super.key,required this.title,this.isSelected=false});
final String title;
 final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return
      Text(title,

      style: getRegularStyle(color:isSelected?
    AppColors.Pink:AppColors.midGray,
        fontSize: 18.0).copyWith(
      decoration: isSelected==false? TextDecoration.underline:null,
height: 2.1,

decorationThickness:2.5,
      decorationColor: isSelected?Colors.transparent:AppColors.midGray
    ),);
  }
}
