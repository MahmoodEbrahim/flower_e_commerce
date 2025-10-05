 import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/orders/presentation/view/widgets/active_widget.dart';
import 'package:flower_e_commerce/features/orders/presentation/view/widgets/completed_widget.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/Orders_View_model.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_events.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/common_loading.dart';
import '../../../domain/entity/order_entity/orders_entity.dart';

class OrderPage extends StatefulWidget{
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrdersViewModel Order=getIt.get<OrdersViewModel>();
  int selected=0;
  @override
  void initState() {
    Order.add(GetOrderEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Order,

  child: Scaffold(
    backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
           Navigator.of(context).
           pushNamed(AppRoutes.home);
          },
              icon: Icon(Icons.arrow_back_ios_new_sharp)),
          backgroundColor: AppColors.white,
          title: Text(AppLocalizations.of(context)!.orderPage),
        ),
        body:DefaultTabController(length: 2,
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
labelStyle:                       getMediumStyle(color: AppColors.pink,fontSize: 18.sp),

                      unselectedLabelStyle:
                         getMediumStyle(color: AppColors.gray,fontSize: 18.sp),
                      onTap: (index){
                        selected=index;
                        setState(() {

                        });
                      },


                      indicator:BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16)) ,
                      isScrollable: true,

                      tabAlignment: TabAlignment.center,

                      dividerHeight: 0,
                      indicatorColor: AppColors.pink,
                      tabs:[Tab(text:AppLocalizations.of(context)!.active ,


                      ),
                        Tab(text:AppLocalizations.of(context)!.completed,

                        )] ),

                ],),
              BlocConsumer<OrdersViewModel,OrderStates>(
  listener: (context, state) {
   if(state.errorMessage!=null){
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(state.errorMessage!)));

     state.errorMessage = null;

   }
  },
  builder: (context, state) {
    if (state.isLoading){
      return  CommonLoading();
    }

    if(state.OrdersResonse!=null) {
      List<OrdersEntity>activeorders=state.OrdersResonse!.orders!.where((order) => order.state=="pending").toList();
      List<OrdersEntity>completedorders=state.OrdersResonse!.orders!.where((order) => order.state=="completed").toList();

      return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBarView(physics: NeverScrollableScrollPhysics(),


                children: [
                  ActiveWidget(orders: activeorders,),
                  CompletedWidget(orders: completedorders,)

                ]
            )
        ),
      );
    }
    else {
      return SizedBox();
    }
  },
)

            ],
          ),

        )
    ),
);
  }
}