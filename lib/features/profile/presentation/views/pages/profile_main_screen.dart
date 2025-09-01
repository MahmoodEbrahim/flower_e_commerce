import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({super.key});

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  LoginModel? user;
  bool isNotificationEnabled = true;

  @override
  void initState() {
    super.initState();
    user = UserLocalStorage.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

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
              locale.flowery,
              style: GoogleFonts.imFellEnglish(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s24,
                color: AppColors.Pink,
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
      body: Column(
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
                color: AppColors.Pink,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user?.user.firstName ?? locale.guest,
                style: getMediumStyle(
                  color: AppColors.Black,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  ///Navigator to edit profile
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
                leading:
                    SvgPicture.asset(ImageAssets.list, height: 25, width: 25),
                title: locale.myOrders,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              ProfileItem(
                leading: SvgPicture.asset(ImageAssets.location,
                    height: 25, width: 25),
                title: locale.savedAddress,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              const Divider( height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 5),
                child: Row(
                  children: [
                    Switch(
                      value: isNotificationEnabled,
                      onChanged: (value) {
                        setState(() {
                          isNotificationEnabled = value;
                        });
                      },
                      activeColor: AppColors.White,
                      activeTrackColor: AppColors.Pink,
                      inactiveThumbColor: AppColors.gray,
                      inactiveTrackColor: AppColors.White,
                    ),
                    SizedBox(width: 3,),
                    Text(locale.notification,
                        style: getRegularStyle(
                            color: AppColors.Black, fontSize: FontSize.s16)),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ///navigator
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 20, color: AppColors.Black),
                    )
                  ],
                ),
              ),
              const Divider(height: 20,),
              ProfileItem(
                leading: SvgPicture.asset(ImageAssets.translate, height: 20),
                title: locale.language,
                trailing: Text(
                  locale.english,
                  style: getRegularStyle(
                    color: AppColors.Pink,
                    fontSize: FontSize.s16,
                  ),
                ),
                onTap: () {
                  // navigator
                },
              ),
              ProfileItem(
                title: locale.aboutUs,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              ProfileItem(
                title: locale.termsAndConditions,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              const Divider(),
              ProfileItem(
                leading: SvgPicture.asset(ImageAssets.logout, height: 20),
                title: locale.logout,
                trailing: SvgPicture.asset(ImageAssets.logout, height: 30),
                onTap: () {
                  // navigator
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
