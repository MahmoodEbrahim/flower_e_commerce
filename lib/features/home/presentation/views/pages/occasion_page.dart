import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/common_widgets/no_products.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_states.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_grid.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//end of this
class OccasionPage extends StatefulWidget {
   OccasionPage({ this.occasions});
List<OccasionsEntity>?occasions;
  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {

  int currIndex=0;



 // List<occasionTab>tabs=[
 //   occasionTab(title: "Weeding", id: "673b34c21159920171827ae0",),
 //   occasionTab(title: "Graduation", id: "673b351e1159920171827ae5",),
 //   occasionTab(title: "Birthday", id: "673b354b1159920171827ae8",),
 //   occasionTab(title: "Anniversary", id: "673b35c01159920171827aed",),
 //   occasionTab(title: "New Year", id: "673b364e1159920171827af9",),
 //   occasionTab(title: "Mother's Day", id: "673b36e71159920171827b05",),
 //   occasionTab(title: "Father's Day",id: "673b37511159920171827b0e",),
 //    occasionTab(title: "Christmas",id: "673b37a31159920171827b13",),
 //    occasionTab(title: "Easter",id: "673b37c41159920171827b16",),
 //    occasionTab(title: "Baby Shower",id: "673b382e1159920171827b19",),
 //    occasionTab(title: "Engagement",id: "673b38641159920171827b1d",),
 //   occasionTab(title: "Friendship Day",id: "673b38a91159920171827b20",),
 //    occasionTab(title: "Get Well Soon",id: "673b38d01159920171827b25",),
 //    occasionTab(title: "Apology",id: "673b39241159920171827b28",),
 //   occasionTab(title: "electronicssdsssw",id: "6899d319a8bca307f9db0e16",),
 // ];
  List<ProductsEntity> fakeOccasions = [
    ProductsEntity(
      id: "673b34c21159920171827ae0",
      title: "Wedding",
      price: 400,
      priceAfterDiscount: 300,
      images: [
        "https://flower.elevateegy.com/uploads/da6919e9-6d7b-4e1e-9578-1c5b6fd098b2-sofia-hernandez-8CqDvPuo_kI-unsplash.jpg"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/da6919e9-6d7b-4e1e-9578-1c5b6fd098b2-sofia-hernandez-8cCfjxR8KTw-unsplash.jpg",
      quantity: 1,
      description: "Celebrate your special wedding day with beautiful flowers.",
    ),
    ProductsEntity(
      id: "673b351e1159920171827ae5",
      title: "Graduation",
      price: 700,
      priceAfterDiscount: 400,
      images: [
        "https://flower.elevateegy.com/uploads/33f50c5b-2f99-4a64-90d3-e50cbf1d8727-vasily-koloda-8CqDvPuo_kI-unsplash.jpg"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/33f50c5b-2f99-4a64-90d3-e50cbf1d8727-vasily-koloda-8CqDvPuo_kI-unsplash.jpg",
      quantity: 1,
      description: "Congratulate the graduate with stunning floral arrangements.",
    ),
    ProductsEntity(
      id: "673b354b1159920171827ae8",
      title: "Birthday",
      price: 2076,
      priceAfterDiscount: 1234,
      images: [
        "https://flower.elevateegy.com/uploads/fb2a0878-d236-4954-9720-9668d2ee5d30-ana-tavares-4Lmzh6vVLJ8-unsplash.jpg"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/fb2a0878-d236-4954-9720-9668d2ee5d30-ana-tavares-4Lmzh6vVLJ8-unsplash.jpg",
      quantity: 1,
      description: "Make birthdays memorable with vibrant flower bouquets.",
    ),
    ProductsEntity(
      id: "673b35c01159920171827aed",
      title: "Anniversary",
      price: 600,
      priceAfterDiscount: 700,
      images: [
        "https://flower.elevateegy.com/uploads/d6971db8-4fdc-4d4d-b87e-c997d79e8f1b-Rectangle 3862.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/d6971db8-4fdc-4d4d-b87e-c997d79e8f1b-Rectangle 3862.png",
      quantity: 1,
      description: "Celebrate your anniversary with elegant floral gifts.",
    ),
    ProductsEntity(
      id: "673b364e1159920171827af9",
      title: "New Year",
      price:1234,
      priceAfterDiscount: 700,
      images: [
        "https://flower.elevateegy.com/uploads/dad03ac6-87ea-4467-aaea-0ef5fe9b0076-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/dad03ac6-87ea-4467-aaea-0ef5fe9b0076-flower_image.png",
      quantity: 1,
      description: "Welcome the New Year with festive flower decorations.",
    ),
    ProductsEntity(
      id: "673b368c1159920171827afc",
      title: "Valentine's Day",
      price: 700,
      priceAfterDiscount:600 ,
      images: [
        "https://flower.elevateegy.com/uploads/a6ecd2f0-85ca-412e-bb08-3693b00dbc1f-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/a6ecd2f0-85ca-412e-bb08-3693b00dbc1f-flower_image.png",
      quantity: 1,
      description: "Express love with Valentine’s Day flower arrangements.",
    ),
    ProductsEntity(
      id: "673b36e71159920171827b05",
      title: "Mother's Day",
      price: 500,
      priceAfterDiscount: 450,
      images: [
        "https://flower.elevateegy.com/uploads/f2be4ed7-de98-42d1-9958-0aa7039c0ec3-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/f2be4ed7-de98-42d1-9958-0aa7039c0ec3-flower_image.png",
      quantity: 1,
      description: "Honor moms with beautiful Mother’s Day flowers.",
    ),
    ProductsEntity(
      id: "673b37511159920171827b0e",
      title: "Father's Day",
      price: 890,
      priceAfterDiscount: 800,

      images: [
        "https://flower.elevateegy.com/uploads/6f60ae3d-bc4f-4d57-bf87-63e91bcb7d50-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/6f60ae3d-bc4f-4d57-bf87-63e91bcb7d50-flower_image.png",
      quantity: 1,
      description: "Celebrate dads with unique Father’s Day floral gifts.",
    ),
    ProductsEntity(
      id: "673b37a31159920171827b13",
      title: "Christmas",
      price: 945,
      priceAfterDiscount: 800,
      images: [
        "https://flower.elevateegy.com/uploads/cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png",
      quantity: 1,
      description: "Decorate for Christmas with festive flower arrangements.",
    ),
    ProductsEntity(
      id: "673b37c41159920171827b16",
      title: "Easter",
      price: 850,
      priceAfterDiscount: 800,
      images: [
        "https://flower.elevateegy.com/uploads/7b9318b5-5c7f-4cb5-a9aa-b02590e57fbc-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/7b9318b5-5c7f-4cb5-a9aa-b02590e57fbc-flower_image.png",
      quantity: 1,
      description: "Celebrate Easter with colorful floral decorations.",
    ),
    ProductsEntity(
      id: "673b382e1159920171827b19",
      title: "Baby Shower",
      price: 200,
      priceAfterDiscount: 150,
      images: [
        "https://flower.elevateegy.com/uploads/2ba4ace8-446b-4705-ab4d-dcecc64918f3-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/2ba4ace8-446b-4705-ab4d-dcecc64918f3-flower_image.png",
      quantity: 1,
      description: "Welcome the new baby with baby shower flowers.",
    ),
    ProductsEntity(
      id: "673b38641159920171827b1d",
      title: "Engagement",
      price: 800,
      priceAfterDiscount: 700,
      images: [
        "https://flower.elevateegy.com/uploads/43621086-b702-40d0-8e3f-a633564de4b2-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/43621086-b702-40d0-8e3f-a633564de4b2-flower_image.png",
      quantity: 1,
      description: "Celebrate engagements with romantic flower arrangements.",
    ),
    ProductsEntity(
      id: "673b38a91159920171827b20",
      title: "Friendship Day",
      price: 1000,
      priceAfterDiscount: 800,
      images: [
        "https://flower.elevateegy.com/uploads/c7cc73e9-db9d-4c3d-9106-eb2ff90e8d20-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/c7cc73e9-db9d-4c3d-9106-eb2ff90e8d20-flower_image.png",
      quantity: 1,
      description: "Show friendship with special Day flower gifts.",
    ),
    ProductsEntity(
      id: "673b38d01159920171827b25",
      title: "Get Well Soon",
      price: 900,
      priceAfterDiscount: 800,
      images: [
        "https://flower.elevateegy.com/uploads/fdbe5102-aa87-4236-9487-8aebd9e3be80-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/fdbe5102-aa87-4236-9487-8aebd9e3be80-flower_image.png",
      quantity: 1,
      description: "Send get well soon wishes with healing flowers.",
    ),
    ProductsEntity(
      id: "673b39241159920171827b28",
      title: "Apology",
      price: 900,
      priceAfterDiscount: 800,
      images: [
        "https://flower.elevateegy.com/uploads/20cf856d-33e2-489f-af08-21a23bd6ecce-flower_image.png"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/20cf856d-33e2-489f-af08-21a23bd6ecce-flower_image.png",
      quantity: 1,
      description: "Apologize with heartfelt flower arrangements.",
    ),
    ProductsEntity(
      id: "6899d319a8bca307f9db0e16",
      title: "electronicssdsssw",
      price: 300,
      priceAfterDiscount: 250,
      images: [
        "https://flower.elevateegy.com/uploads/db792d98-a55e-4b12-9a1f-423ec235d05e-497914489_122191691174049429_5884330870764514808_n.jpg"
      ],
      imgCover: "https://flower.elevateegy.com/uploads/db792d98-a55e-4b12-9a1f-423ec235d05e-497914489_122191691174049429_5884330870764514808_n.jpg",
      quantity: 1,
      description: "Unique electronic-themed floral design.",
    ),

  ];
  final ProductsDetialsOccasionBloc occasionBloc=
  getIt.get<ProductsDetialsOccasionBloc>();
   @override
   Widget build(BuildContext context) {
     var local=AppLocalizations.of(context);
     return BlocProvider.value(
       value: occasionBloc..add(
         GetProductsDetialsByOccasionEvent(
           occassionId: widget.occasions![currIndex].id!,
         ),
       ),
       child: Scaffold(

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
                         IconButton(onPressed: (){
                                    Navigator.of(context).pop();
                         }, icon:   Icon(Icons.arrow_back_ios_new,size:
                         28.0,color: AppColors.lightBlack,),),

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
                 DefaultTabController(length: widget.occasions!.length,
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

                       tabs: List.generate( widget.occasions!.length, (index)=>occasionTab(
                         title: widget.occasions![index].name!,
                         id:  widget.occasions![index].id!,
                         isSelected:
                         index==currIndex,))),),
                 SizedBox(height: 16.0,),
                 BlocBuilder<ProductsDetialsOccasionBloc,OccasionStates>(builder: (context,state){
              switch(state.requestState){

                case RequestState.init:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children:
                 [
                   SizedBox(height: 200.0,),
                   LoadingAnimationWidget.inkDrop(color: AppColors.Pink,
                       size: 50)
                 ],);
                case RequestState.loading:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children:
                    [
                      SizedBox(height: 230.0,),
                      LoadingAnimationWidget.inkDrop(color: AppColors.Pink,
                          size: 50)
                    ],);

                case RequestState.success:
                  // TODO: Handle this case.
                  return  state.productsDetials.isNotEmpty?Expanded(child: OccasionGrid(
                    occasion: state.productsDetials,
                  )):NoProducts();
                case RequestState.error:
                return Center(child: Text(state.errorMessage!),);
              }
                 })

               ],
             ),),)
       ),
     );
   }

}

