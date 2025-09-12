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
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

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
        leading: IconButton(onPressed: ()=>Navigator.of(context).pushNamed(AppRoutes
            .home),
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: BlocConsumer<AddressBloc,AddressState>(
          listener: (context,state){
            if(state.deleteAddressRequestState==RequestState.error){
              print("error in deleting ${state.deleteAddressErrorMessage}");

            }
            if(state.getAddressRequestState==RequestState.success){
       UserLocalStorage.saveUser(LoginModel(
           user: UserModel(
             addresses: state.addressEntity
           ),
           token: token!));

            }
          },
          builder: (context,state){
       return Padding(padding: EdgeInsets.symmetric(
         horizontal: 20.0
       ),child:state.getAddressRequestState==RequestState.loading ?
      Center(child:  LoadingAnimationWidget.inkDrop(color: AppColors.pink,
          size: 50.sp),)
           :


             Column(
               children: [
                 state.addresses.isEmpty?       Center(
                     child:
                     Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                         Lottie.asset("assets/json/search_location.json",fit: BoxFit.cover,
                             height: 200.h,width: 300.w
                         ),
                         SizedBox(height: 60.h,),
                         Text("No Saved Addresses Yet",style:
                         getBoldStyle(color: AppColors.pink,fontSize: 16.sp).copyWith(
                             fontFamily: GoogleFonts.adamina().fontFamily
                         )).animate(

                         ).fadeIn()
                       ],
                     )
                 ):       Expanded(
                     child:  ListView.separated(itemBuilder:
                         (context,index){
                       return CustomAddressWidget
                         (addressEntity: state.addresses[index]);
                     },
                       separatorBuilder: (context,index){
                         return SizedBox(height: 16.h,);
                       },itemCount:state.addresses.length ,)),




               ],
             ),


    );

      }),
      bottomNavigationBar:
          Padding(padding: EdgeInsets.all(16),
          child:  CustomBtnWidget(txt: "Add New Address",onPressed: (){
            Navigator.of(context).pushNamed(AppRoutes.addAddress);
          },) ,
          )


    )
    );

  }
}
