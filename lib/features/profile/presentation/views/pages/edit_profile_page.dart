import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_state.dart';
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
  File? savedFile;
  String? _gender;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>(),
      child: BlocBuilder<UserSessionBloc, UserSessionState>(
        builder: (context, sessionState) {
          final userModel = sessionState.user;
          final token = sessionState.token;

          // جهز الـ controllers بالقيم الحالية
          _firstNameController.text = userModel?.firstName ?? '';
          _lastNameController.text = userModel?.lastName ?? '';
          _emailController.text = userModel?.email ?? '';
          _phoneController.text = userModel?.phone ?? '';
          _gender = userModel?.gender;

          return BlocConsumer<EditProfileBloc, EditProfileStates>(
            listener: (context, state) {
              if (state.editProfileState == RequestState.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(local.profileUpdatedSuccessfully)),
                );
                Navigator.pop(context);
              } else if (state.editProfileState == RequestState.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessageEditProfile!)),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.blackColor[60]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(local.editProfile),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (token == null) return;
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(source: ImageSource.camera);
                          if (pickedFile != null) {
                            final directory = await getApplicationDocumentsDirectory();
                            final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
                            savedFile = await File('${directory.path}/$fileName')
                                .writeAsBytes(await pickedFile.readAsBytes());

                            context.read<EditProfileBloc>().add(
                              GetUploadProfileEvent(
                                photo: savedFile!,
                                token: token,
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: savedFile != null
                              ? FileImage(savedFile!)
                              : NetworkImage(
                            userModel?.photo ??
                                'https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg',
                          ) as ImageProvider,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTxtFieldWidget(
                        controller: _firstNameController,
                        lbl: local.firstName,
                        hint: local.firstName,
                      ),
                      CustomTxtFieldWidget(
                        controller: _lastNameController,
                        lbl: local.lastName,
                        hint: local.lastName,
                      ),
                      CustomTxtFieldWidget(
                        controller: _emailController,
                        lbl: local.email,
                        hint: local.email,
                      ),
                      CustomTxtFieldWidget(
                        controller: _phoneController,
                        lbl: local.phoneNumber,
                        hint: local.phoneNumber,
                      ),
                      CustomBtnWidget(
                        txt: local.update,
                        onPressed: () {
                          if (token == null) return;
                          final request = EditProfileRequest(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                          );

                          context.read<EditProfileBloc>().add(
                            GetEditProfileEvent(token: token, request: request),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
