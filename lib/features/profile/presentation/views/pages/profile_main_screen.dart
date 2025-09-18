import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/user_session_view_model/user_session_event.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/app_language/app_language_cubit.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/language_row_widget.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/login_first_dialog.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/logout_dialog.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../config/routes_manager/app_routes.dart';
import '../../../../auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import '../../../../auth/presentation/view_model/user_session_view_model/user_session_state.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({super.key});

  @override
  State<ProfileMainPage> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainPage> {
  bool isNotificationEnabled = true;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
    context.read<UserSessionBloc>().add(LoadUserFromCache());
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
    final cubit = BlocProvider.of<LanguageCubit>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(ImageAssets.flower, height: 35, width: 35),
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
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notificationspage);
            },
            child: const Icon(
              Icons.notifications_none,
              size: 30,
              color: AppColors.gray,
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      body: BlocBuilder<UserSessionBloc, UserSessionState>(
        builder: (context, state) {
          final user = state.user;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.lightPink,
                  child: const Icon(Icons.person_outline, size: 50, color: AppColors.pink),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.firstName ?? t.guest,
                    style: getMediumStyle(color: AppColors.black, fontSize: FontSize.s18),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      if (user == null) {
                        loginInDialgo(context, t);
                      } else {
                        final updatedUser = await Navigator.of(context)
                            .pushNamed(AppRoutes.editProfilePage);
                        if (updatedUser != null && updatedUser is LoginModel) {
                          context.read<UserSessionBloc>().add(LoadUserFromCache());
                        }
                      }
                    },
                    child: SvgPicture.asset(ImageAssets.pen, width: 24, height: 24),
                  ),
                ],
              ),
              Text(
                user?.email ?? "",
                style: getMediumStyle(color: AppColors.gray, fontSize: FontSize.s18),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.list, height: 25, width: 25),
                    title: t.myOrders,
                    showArrow: true,
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.orderspage),
                  ),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.location, height: 25, width: 25),
                    title: t.savedAddress,
                    showArrow: true,
                    onTap: () {
                      if (user == null) {
                        loginInDialgo(context, t);
                      } else {
                        Navigator.of(context).pushNamed(AppRoutes.saveAddress);
                      }
                    },
                  ),
                  const Divider(height: 20),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.translate, height: 20),
                    title: t.language,
                    trailing: Text(
                      cubit.currentLanguage == "ar" ? t.arabic : t.english,
                      style: getRegularStyle(color: AppColors.pink, fontSize: FontSize.s16),
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
                        builder: (context) => Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LanguageRow(
                                title: t.arabic,
                                value: "ar",
                                selected: cubit.currentLanguage,
                                onChanged: (value) => cubit.changeLanguage("ar"),
                              ),
                              LanguageRow(
                                title: t.english,
                                value: "en",
                                selected: cubit.currentLanguage,
                                onChanged: (value) => cubit.changeLanguage("en"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileItem(
                    title: t.aboutUs,
                    showArrow: true,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.about),
                  ),
                  ProfileItem(
                    title: t.termsAndConditions,
                    showArrow: true,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.termsAndCondition),
                  ),
                  const Divider(),
                  ProfileItem(
                    leading: SvgPicture.asset(ImageAssets.logout, height: 20),
                    title: t.logout,
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
                        style: getRegularStyle(color: AppColors.gray, fontSize: FontSize.s14)),
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
