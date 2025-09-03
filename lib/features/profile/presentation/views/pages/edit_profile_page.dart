import 'dart:io';

import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile_events.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    final token =UserLocalStorage.getToken();
    return BlocProvider(create: (context)=>getIt<EditProfileBloc>(),
    child:  Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        backgroundColor: AppColors.White,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.black[60]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          local.editProfile,
          style: getMediumStyle(color: AppColors.black,
              fontSize: FontSize.s20),
        ),
        actions: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Icon(CupertinoIcons.bell
                ,color: AppColors.Black,size: 40.0,),
              CircleAvatar(
                backgroundColor: AppColors.red,
                radius: 10,
                child: Text("3",style: TextStyle(
                    color: AppColors.White
                ),),
              )
            ],
          ),
          SizedBox(width: 20.w,)
        ],
      ),
      body:BlocConsumer<EditProfileBloc,EditProfileStates>
        (builder: (context,state){
          return       Column(
            children: [
              GestureDetector(
                  onTap: ()async{
                    ImagePicker _picker=ImagePicker();
                    final pickedFile=await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final file = File(pickedFile.path);

                      final bloc = context.read<EditProfileBloc>();
                      bloc.add(GetUploadProfileEvent
                        (photo: file, token: token!));
                    }
                  },
                  child:  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: NetworkImage("https://iv1.lisimg.com/image/24939495/740full-andjela-vlaisavljevi%C4%87.jpg"),
                      ),
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: AppColors.lightPink,
                            borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Icon(CupertinoIcons.camera,color: AppColors.Black,),
                      )
                    ],
                  )
              ),

            ],
          );
      }, listener: (context,state){
if(state.uploadPhotoState==RequestState.success){

}
      })


    )
    )
     ;
  }
}
