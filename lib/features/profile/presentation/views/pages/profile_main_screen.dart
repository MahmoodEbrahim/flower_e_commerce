import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/language_row_widget.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/logout_dialog.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../config/routes_manager/app_routes.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({super.key});

  @override
  State<ProfileMainPage> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainPage> {
  LoginModel? user;
  bool isNotificationEnabled = true;
  String appVersion = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData(); // Load user data when dependencies change
    _loadVersion();
  }

  Future<LoginModel> _loadUserData() async {
    await UserLocalStorage.init(); // Ensure initialization
    setState(() {
      user = UserLocalStorage.getUser();
    });
    return user!;
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = '${info.version} - (${info.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    LanguageCubit cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageAssets.flower,
              height: 35,
              width: 35,
            ),
            const SizedBox(width: 6),
            Text(
              t.flowery,
              style: GoogleFonts.imFellEnglish(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s24,
                color: AppColors.pink,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.notifications_none,
            size: 30,
            color: AppColors.gray,
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      body: FutureBuilder<LoginModel?>(
        future: _loadUserData(), // Load user data asynchronously
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          // if (snapshot.hasError || snapshot.data == null) {
          //   return Center(child: Text(t.errorMessage));
          // }
          user = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.lightPink,
                  child: const Icon(
                    Icons.person_outline,
                    size: 50,
                    color: AppColors.pink,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.user.firstName ?? t.guest,
                    style: getMediumStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      final updatedUser = await Navigator.of(context)
                          .pushNamed(AppRoutes.editProfilePage);
                      if (updatedUser != null) {
                        setState(() {
                          user = updatedUser as LoginModel?;
                        });
                      }
                    },
                    child: SvgPicture.asset(
                      ImageAssets.pen,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
              Text(
                user?.user.email ?? "",
                style: getMediumStyle(
                  color: AppColors.gray,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.list, height: 25, width: 25),
                    title: t.myOrders,
                    showArrow: true,
                    onTap: () {
                      // navigator
                    },
                  ),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.location, height: 25, width: 25),
                    title: t.savedAddress,
                    showArrow: true,
                    onTap: () {
                      // navigator
                      Navigator.of(context).pushNamed(AppRoutes.addAddress);
                    },
                  ),
                  const Divider(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Row(
                      children: [
                        Switch(
                          value: isNotificationEnabled,
                          onChanged: (value) {
                            setState(() {
                              isNotificationEnabled = value;
                            });
                          },
                          activeColor: AppColors.white,
                          activeTrackColor: AppColors.pink,
                          inactiveThumbColor: AppColors.gray,
                          inactiveTrackColor: AppColors.white,
                        ),
                        const SizedBox(width: 3),
                        Text(t.notification,
                            style: getRegularStyle(
                                color: AppColors.black, fontSize: FontSize.s16)),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ///navigator
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded,
                              size: 20, color: AppColors.black),
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 20),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.translate, height: 20),
                    title: t.language,
                    trailing: Text(
                      t.english,
                      style: getRegularStyle(
                        color: AppColors.pink,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
                        ),
                        builder: (context)=>Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.r),
                              topRight: Radius.circular(32.r),
                            ),
                            color: AppColors.white,

                          ),
                          padding: REdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 80.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkGrey,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h,),
                              Text(
                                AppLocalizations.of(context)!.
                              changelanguage,style: Theme.of(context).textTheme.bodyLarge,),
                              SizedBox(height: 16.h,),
                              LanguageRow(title: AppLocalizations.of(context)!.arabic ,value: "ar",selected: cubit.currentLanguage,onChanged: (value){
                                cubit.changeLanguage("ar");
                              },),
                              SizedBox(height: 16.h,),
                              LanguageRow(title:AppLocalizations.of(context)!.english  ,value: "en",selected: cubit.currentLanguage,onChanged: (value){

                                cubit.changeLanguage("en");

                              },),
                            ],
                          ),
                        ) ,);
                    },
                  ),
                  ProfileItem(
                    title: t.aboutUs,
                    showArrow: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.about);
                    },
                  ),
                  ProfileItem(
                    title: t.termsAndConditions,
                    showArrow: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.termsAndCondition);
                    },
                  ),
                  const Divider(),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.logout, height: 20),
                    title: t.logout,
                    trailing: SvgPicture.asset(ImageAssets.logout, height: 30),
                    onTap: user == null
                        ? null
                        : () {
                      showDialog(
                        context: context,
                        builder: (context) => const LogoutDialog(),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('${t.version}$appVersion',
                        style: getRegularStyle(
                            color: AppColors.gray, fontSize: FontSize.s14)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
