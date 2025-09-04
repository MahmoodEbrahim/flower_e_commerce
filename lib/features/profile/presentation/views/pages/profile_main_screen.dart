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
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../config/routes_manager/app_routes.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({super.key});

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {
  LoginModel? user;
  bool isNotificationEnabled = true;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    user = UserLocalStorage.getUser();
    _loadVersion();
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                user?.user.firstName ?? t.guest,
                style: getMediumStyle(
                  color: AppColors.Black,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, AppRoutes.editUser,
                  // arguments: user);
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
                title: t.myOrders,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              ProfileItem(
                leading: SvgPicture.asset(ImageAssets.location,
                    height: 25, width: 25),
                title: t.savedAddress,
                showArrow: true,
                onTap: () {
                  // navigator
                },
              ),
              const Divider( height: 20,),
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
                      activeColor: AppColors.White,
                      activeTrackColor: AppColors.Pink,
                      inactiveThumbColor: AppColors.gray,
                      inactiveTrackColor: AppColors.White,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(t.notification,
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
                title: t.language,
                trailing: Text(
                  t.english,
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
                  showLogoutDialog(context);
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
        ]));
  }
}
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "LOGOUT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Confirm logout!!",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  // Logout button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      UserLocalStorage.clearUser();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.home,
                            (route) => false,
                      );                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
