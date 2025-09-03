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
import 'package:path_provider/path_provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  Future<File> _saveTemporaryFile(XFile pickedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    final savedFile = await File('${directory.path}/$fileName').writeAsBytes(await pickedFile.readAsBytes());
    return savedFile;
  }
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    final token =UserLocalStorage.getToken();
     File? savedFile;
    print("token is $token");
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
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                       savedFile = await _saveTemporaryFile(pickedFile);
                      final bloc = context.read<EditProfileBloc>();
                      if (token != null) {
                        bloc.add(GetUploadProfileEvent(photo: savedFile!, token: token));
                      } else {
                        print("Token is null, upload aborted");
                      }
                    }
                  },
                  child:  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage:savedFile==null?
                        NetworkImage("https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg"):FileImage(savedFile!),
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
print("Success in upload photo");
}
if(state.uploadPhotoState==RequestState.error){
  print("Error ${state.errorMessageUploadPhoto}");
}
      })


    )
    )
     ;
  }
}
