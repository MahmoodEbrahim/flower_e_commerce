import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/presentation/view/screen/update_screen.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressWidget extends StatelessWidget {
   CustomAddressWidget({super.key,required this.addressEntity});
final AddressEntity addressEntity;
final token=UserLocalStorage.getToken()!;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> valueListenable = ValueNotifier(false);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        
        border: Border.all(
          color: AppColors.white ,width:3.w
        ),

      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined,size: 26.0,color: AppColors.black,),
            SizedBox(width: 10.w,),
            Text(addressEntity.city!,style:
            getMediumStyle(color: AppColors.black,fontSize: 16.sp),),
            Spacer(),
            ValueListenableBuilder<bool>(
              valueListenable: valueListenable,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    final token = UserLocalStorage.getToken();
print("id ${addressEntity.id}");
                    print("id ${addressEntity.city}");
print("token ${token}");

                    if (token != null && addressEntity.id != null) {
                      context.read<AddressBloc>().add(
                        DeleteAddressEvent(
                          token: token,
                          id: addressEntity.id!,
                        ),
                      );



                      valueListenable.value = !value;
                      context.read<AddressBloc>().add(GetAllddressEvent(token: token));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Missing token or id")),
                      );
                    }
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                    color: AppColors.red,
                  ),
                );
              },
            )
,

            IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (conext)=>UpdateAddressScreen(
                  address: addressEntity)));

            },
                icon: Icon(Icons.mode_edit_outline,size: 20.sp,color: AppColors.black,))
          ],
        ),
          SizedBox(height: 6.h,),
          Text("2XVP+XC- ${addressEntity.street!}",
            style: getRegularStyle(color: AppColors.midGray,
          fontSize: 14.sp
          ),),

        ],
      ) ,
    );
  }
}
