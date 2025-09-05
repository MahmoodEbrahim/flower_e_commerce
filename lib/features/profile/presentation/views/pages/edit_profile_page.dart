import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_events.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/edit_profile/edit_profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Future<File> _saveTemporaryFile(XFile pickedFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    final savedFile = await File(
      '${directory.path}/$fileName',
    ).writeAsBytes(await pickedFile.readAsBytes());
    return savedFile;
  }

  File? savedFile;
  LoginModel userModel = UserLocalStorage.getUser()!;
  final token = UserLocalStorage.getToken();
  String? _gender;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = userModel.user.firstName ?? '';
    _lastNameController.text = userModel.user.lastName ?? '';
    _emailController.text = userModel.user.email ?? '';
   // _passwordController.text = userModel.user.Id ?? '';
    _phoneController.text = userModel.user.phone ?? '';
    _gender = userModel.user.gender;
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  //  _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.blackColor[60]),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            local.editProfile,
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: FontSize.s20,
            ),
          ),
          actions: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Icon(CupertinoIcons.bell, color: AppColors.black, size: 35.0),
                CircleAvatar(
                  backgroundColor: AppColors.red,
                  radius: 9,
                  child: Text(
                    "3",
                    style: TextStyle(color: AppColors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
          ],
        ),
        body: BlocConsumer<EditProfileBloc, EditProfileStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedFile != null) {
                        savedFile = await _saveTemporaryFile(pickedFile);
                        final bloc = context.read<EditProfileBloc>();
                        if (token != null) {
                          bloc.add(
                            GetUploadProfileEvent(
                              photo: savedFile!,
                              token: token!,
                            ),
                          );
                        } else {
                          print("Token is null, upload aborted");
                        }
                      }
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50.r,

                          backgroundImage:
                              state.uploadProfilePhotoResponse == null
                              ? CachedNetworkImageProvider(
                                  userModel.user.photo == null
                                      ? "https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg"
                                      : userModel.user.photo!,
                                )
                              : FileImage(savedFile!),
                        ),
                        Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.lightPink,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            CupertinoIcons.camera,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTxtFieldWidget(
                          controller: _firstNameController,
                          lbl: local.firstName,
                          hint: local.firstName,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: CustomTxtFieldWidget(
                          controller: _lastNameController,
                          lbl: local.lastName,
                          hint: local.lastName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  CustomTxtFieldWidget(
                    controller: _emailController,
                    lbl: local.email,
                    hint: local.email,
                  ),
                  SizedBox(height: 20.0),
                  CustomTxtFieldWidget(
                    controller: _phoneController,
                    lbl: local.phoneNumber,
                    hint: local.phoneNumber,
                  ),
                  SizedBox(height: 20.0),
                  CustomTxtFieldWidget(
                    controller: _passwordController,
                    lbl: "",
                    hint: local.password,
                    isPass: true,
                    isSuffix: true,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        local.gender,
                        style: getMediumStyle(
                          color: AppColors.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<String>(
                              activeColor: AppColors.pink,
                              focusColor: AppColors.pink,
                              fillColor: WidgetStateProperty.all(
                                AppColors.pink,
                              ),
                              value: 'female',
                              groupValue: _gender,
                              onChanged: null,
                            ),
                            Text(local.female),
                            Radio<String>(
                              value: 'male',
                              focusColor: AppColors.pink,
                              fillColor: WidgetStateProperty.all(
                                AppColors.pink,
                              ),
                              activeColor: AppColors.pink,
                              groupValue: _gender,
                              onChanged: null,
                            ),
                            Text(local.male),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  CustomBtnWidget(
                    txt: local.update,

                    onPressed: () {
                      if (token != null) {
                        final request = EditProfileRequest(
                          firstName: _firstNameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          lastName: _lastNameController.text,
                        );

                        context.read<EditProfileBloc>().add(
                          GetEditProfileEvent(token: token!, request: request),
                        );
                      } else {
                        print("Token is null, update aborted");
                      }
                    },
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state.uploadPhotoState == RequestState.success) {
              print("Success in upload photo");
            }
            if (state.uploadPhotoState == RequestState.error) {
              print("Error ${state.errorMessageUploadPhoto}");
            }
            if (state.editProfileState == RequestState.success) {
              print("Profile updated successfully");
              final updatedUser = LoginModel(
                token: token!,
                user: userModel.user.copyWith(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                ),
              );
              UserLocalStorage.saveUser(updatedUser);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(local.profileUpdatedSuccessfully)),
              );


              Navigator.of(context).pop();
            }
            if (state.editProfileState == RequestState.error) {
              print("Error ${state.errorMessageEditProfile}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: ${state.errorMessageEditProfile}"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
