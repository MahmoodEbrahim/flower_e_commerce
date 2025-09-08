import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/presentation/view/widget/custom_address_widget.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final token=UserLocalStorage.getToken();
    return  BlocProvider(create: (context)=>getIt.get<AddressBloc>()..
    add(GetAllddressEvent(token: token!)),
    child:  Scaffold(
   backgroundColor: Colors.white,
      appBar:   AppBar(
        backgroundColor: Colors.white,
        title: Text("Saved Address",style: getMediumStyle(color: AppColors.black,
            fontSize:20.sp ),),
        leading: IconButton(onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: BlocConsumer<AddressBloc,AddressState>(
          listener: (context,state){
            if(state.deleteAddressRequestState==RequestState.error){
              print("error in deleting ${state.deleteAddressErrorMessage}");

            }
          },
          builder: (context,state){
       return Padding(padding: EdgeInsets.symmetric(
         horizontal: 20.0
       ),child:   Column(
         children: [
           Expanded(child:  ListView.separated(itemBuilder: (context,index){
             return CustomAddressWidget(addressEntity: state.addresses[index]);
           },
             separatorBuilder: (context,index){
               return SizedBox(height: 16.h,);
             },itemCount:state.addresses.length ,)),
           SizedBox(height: 20.h,),
           CustomBtnWidget(txt: "Add New Address",onPressed: (){
             Navigator.of(context).pushNamed(AppRoutes.addAddress);
           },),
           SizedBox(height: 20.h,),

         ],
       ),);

      })

    )
    );


  }
}
