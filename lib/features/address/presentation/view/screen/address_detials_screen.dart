import 'dart:convert';

import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressDetialsScreen extends StatelessWidget {
  const AddAddressDetialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final token=UserLocalStorage.getToken();
    var addressController=TextEditingController();
    var street=TextEditingController();
    var city=TextEditingController();
    var phone=TextEditingController();

    var lang=TextEditingController();
    var lat=TextEditingController();
    var userName=TextEditingController();
    return BlocProvider(create: (context)=>getIt.get<AddressBloc>(),
      child:Scaffold(
        appBar:   AppBar(
          leading: IconButton(onPressed: ()=>Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_sharp)),
        ),
        body: BlocConsumer<AddressBloc,  AddressState>(

            listener:(context,state){
              if(state.addAddressRequestState==RequestState.success){
                print("sucess");
                print(state.addressEntity);
              }

            } ,
            builder: (context,state){
          return   Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
            child:   Column(
            children: [
              CustomTxtFieldWidget(lbl: "Enter the Address", hint: "Address",
                controller: addressController,),
              SizedBox(height: 16.h,),
              CustomTxtFieldWidget(lbl: "Enter the Phone", hint: "Phone number",controller: phone,),
              SizedBox(height: 16.h,),

              CustomTxtFieldWidget(lbl: "Enter the recipient name",
                  hint: "Recipient name",controller: userName,),
              SizedBox(height: 16.h,),
              Row(
                children: [
                  Expanded(child: CustomTxtFieldWidget(lbl: "Enter the city",
                      hint: "City",controller: city,),),
                  SizedBox(width: 16.h,),
                  Expanded(child: CustomTxtFieldWidget(lbl: "Enter the area",
                      hint: "Area",controller: lat,),)

                ],
              ),
              SizedBox(height: 24.h,),
              CustomBtnWidget(txt: "Save Address",onPressed: (){
                context.read<AddressBloc>()..add
                  (GetAddAddressEvent(request: AddAdressRequest(
username: userName.text,
                     city: city.text,
                  long: "lang",
                   lat: lat.text,
                  phone: phone.text,
                  street: "elfalel",

                ), token: token!));
              },)
            ],
          ),);
        })



    ) ,);


  }
}
