import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressWidget extends StatelessWidget {
   CustomAddressWidget({super.key,required this.addressEntity});
final AddressEntity addressEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        
        border: Border.all(
          color:AppColors.gray ,width:2.w
        ),

      ),
      child:Column(
        children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined,size: 20.0,color: AppColors.black,),
            SizedBox(width: 10.w,),
            Text(addressEntity.city!,style:
            getMediumStyle(color: AppColors.black,fontSize: 16.sp),),
            Spacer(),
            IconButton(onPressed: (){},
                icon: Icon(CupertinoIcons.delete_simple,color: AppColors.red,))
,   SizedBox(width: 7.w,),
            IconButton(onPressed: (){},
                icon: Icon(Icons.edit,color: AppColors.black,))
          ],
        ),
          Text(addressEntity.street!,style: getRegularStyle(color: AppColors.midGray,
          fontSize: 13.sp
          ),)
        ],
      ) ,
    );
  }
}
