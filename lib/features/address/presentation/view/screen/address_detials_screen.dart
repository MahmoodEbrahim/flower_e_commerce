

// class AddAddressDetialsScreen extends StatelessWidget {
//   const AddAddressDetialsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final token=UserLocalStorage.getToken();
//     var addressController=TextEditingController();
//     var street=TextEditingController();
//
//     var phone=TextEditingController();
//
//     var lang=TextEditingController();
//     var lat=TextEditingController();
//     var userName=TextEditingController();
//     late final selectedCiy;
//     return BlocProvider(create: (context)=>getIt.get<AddressBloc>()
//       ..add(GetGovernorateEvent()),
//       child:Scaffold(
//         appBar:   AppBar(
//           leading: IconButton(onPressed: ()=>Navigator.pop(context),
//               icon: Icon(Icons.arrow_back_ios_new_sharp)),
//         ),
//         body: BlocConsumer<AddressBloc,  AddressState>(
//
//             listener:(context,state){
//               if(state.addAddressRequestState==RequestState.success){
//                 print(state.addressEntity);
//                 Navigator.of(context).pushNamed(AppRoutes.saveAddress);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("location added Successfuly")));
//               }
//
//
//             } ,
//             builder: (context,state){
//           return   Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child:   Column(
//             children: [
//               CustomTxtFieldWidget(lbl: "Enter the Address", hint: "Address",
//                 controller: addressController,),
//               SizedBox(height: 16.h,),
//               CustomTxtFieldWidget(lbl: "Enter the Phone", hint: "Phone number",controller: phone,),
//               SizedBox(height: 16.h,),
//
//               CustomTxtFieldWidget(lbl: "Enter the recipient name",
//                   hint: "Recipient name",controller: userName,),
//               SizedBox(height: 16.h,),
//               Row(
//                 children: [
//                   //here
//                   Expanded(child:
//                 DropdownButtonFormField<String>
//                   (
//                     value: state.governorates?.isNotEmpty == true
//                         ? state.governorates!.first.id
//                         : null,
//                     decoration: InputDecoration(
//                       labelText: "City",
// border: OutlineInputBorder()
//                     ),
//                     items: state.governorates.map((governate){
// return DropdownMenuItem(
//     value: governate.id,
//     child:Text(governate.nameEn,style:
// getRegularStyle(color: AppColors.gray),));
//                     }).toList(),
//                     onChanged: (value){
//                       selectedCiy=value;
//
//                     })
//                   ),
//                   SizedBox(width: 16.h,),
//                   Expanded(child: CustomTxtFieldWidget(lbl: "Enter the area",
//                       hint: "Area",controller: lat,),)
//
//                 ],
//               ),
//               SizedBox(height: 24.h,),
//               CustomBtnWidget(txt: "Save Address",onPressed: (){
//             //    final selectedCiy=state.governorates.firstWhere((e)=>e.id==(state.governorates.first.id));
//                 context.read<AddressBloc>()..add
//                   (GetAddAddressEvent(request: AddAdressRequest(
// username: userName.text,
//                      city: selectedCiy.nameEn??"",
//                   long: "lang",
//                    lat: lat.text,
//                   phone: phone.text,
//                   street: "elfalel",
//
//                 ), token: token!));
//               },)
//             ],
//           ),);
//         })
//
//
//
//     ) ,);
//
//
//   }
// }
import 'dart:convert';

import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressDetialsScreen extends StatefulWidget {
  const AddAddressDetialsScreen({super.key});

  @override
  State<AddAddressDetialsScreen> createState() => _AddAddressDetialsScreenState();
}

class _AddAddressDetialsScreenState extends State<AddAddressDetialsScreen> {
  final addressController = TextEditingController();

  final phone = TextEditingController();
  final lang = TextEditingController();
  final lat = TextEditingController();
  final userName = TextEditingController();
  String? selectedCity;
String?selectedStreet;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final token = UserLocalStorage.getToken();

    return BlocProvider(
      create: (context) => getIt.get<AddressBloc>()
        ..add(GetGovernorateEvent())
      ,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            ),
            body: BlocConsumer<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state.addAddressRequestState == RequestState.success) {
                  Navigator.of(context).pushNamed(AppRoutes.saveAddress);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Location added Successfully")),
                  );
                }
                if(state.stateRequestState==RequestState.success){
                  print("##########################");
                  print(state.states);
                  print("##########################");

                }
              },
              builder: (context, state) {
                print("Governorates: ${state.governorates}"); // Debug print
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTxtFieldWidget(
                            lbl: "Enter the Address",
                            hint: "Address",
                            controller: addressController),
                        SizedBox(height: 16.h),
                        CustomTxtFieldWidget(
                            lbl: "Enter the Phone",
                            hint: "Phone number",
                            controller: phone),
                        SizedBox(height: 16.h),
                        CustomTxtFieldWidget(
                            lbl: "Enter the recipient name",
                            hint: "Recipient name",
                            controller: userName),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedCity,
                                decoration: const InputDecoration(
                                  labelText: "City",
                                  border: OutlineInputBorder(),
                                ),
                                items: state.governorates?.map((governorate) {
                                  return DropdownMenuItem<String>(
                                    value: governorate.id,
                                    child: Text(
                                      governorate.nameEn,
                                      style: getRegularStyle(color: AppColors.gray,fontSize: 14.sp),
                                    ),
                                  );
                                }).toList() ?? [],

                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedCity = value;
                                      selectedStreet=null;
                                    });
                                    context.read<AddressBloc>()..add(GetStatesEvent
                                      (governateId: value));
                                    print("opo $value");
                                  }

                                },
                                validator: (value) =>
                                value == null ? 'Please select a city' : null,
                                isExpanded: true,
                              ),
                            ),
                            SizedBox(width: 16.h),
                            ///here gork i should call event GetStatesEvent
                            Expanded(
                              child: DropdownButtonFormField<String>
                                (
validator: (value){
  if(value!.isEmpty||value==null){
    return "Please select an Area";
  }else{
    return null;
  }
},
                                isExpanded: true,
                                value: selectedStreet,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Area"
                                  ),
                                  items: state.states?.asMap().entries?.map((entry){
                        var index=entry.key;
                        var val=entry.value;
                        return DropdownMenuItem<String>(
                            value: "$index-${val.cityId}",
                            child: Text(val.cityNameEn,
                            style: getRegularStyle(color: AppColors.gray,fontSize: 14.sp),
                            ));

                                  }).toList(), onChanged: (value){
                               if(value!=null){
                                 selectedStreet=value;

                                 setState(() {

                                 });
                               }

                              })
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        CustomBtnWidget(
                          txt: "Save Address",
                          onPressed: () {
                            final selectedGovernorate = state.governorates?.
                            firstWhere(
                                  (g) => g.id == selectedCity,
                              orElse: () => GovernorateEntity(id: '', nameAr: '', nameEn: ''),
                            );
                            final selectedArea=state.states.firstWhere((s)=>s.cityId==selectedStreet,
                            orElse: ()=>StateEntity(cityId: "", governorateId: "",
                                cityNameAr: "", cityNameEn: "")
                            );
                            context.read<AddressBloc>().add(
                              GetAddAddressEvent(
                                request: AddAdressRequest(
                                  username: userName.text,
                                  city: selectedGovernorate?.nameEn ?? '',
                                  long: "lang",
                                  lat: "lat",
                                  phone: phone.text,
                                  street: selectedArea.cityNameEn??"",
                                ),
                                token: token!,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
