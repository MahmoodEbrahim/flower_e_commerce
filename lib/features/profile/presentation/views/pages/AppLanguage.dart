/*import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/LanguageCubit/language_cubit.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/common_widgets/Language_row.dart';

class applanguage extends StatefulWidget {
  const applanguage({super.key});

  @override
  State<applanguage> createState() => _applanguageState();
}

class _applanguageState extends State<applanguage> {
  @override
  Widget build(BuildContext context) {
    LanguageCubit cubit = BlocProvider.of<LanguageCubit>(context);
    return Scaffold(
     body: SafeArea(
       child: Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [
         Center(
           child: InkWell(
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
                       color: AppColors.White,

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
                         Text(AppLocalizations.of(context)!.changelanguage,style: Theme.of(context).textTheme.bodyLarge,),
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
             child: Row(
               children: [
               SvgPicture.asset(AssetsManager.languageicon,width: 15,height: 15),
                SizedBox(width: 5,),
                Text(AppLocalizations.of(context)!.language,style: TextTheme.of(context).bodyMedium,),
                 SizedBox(width: 210,),
                 Text(AppLocalizations.of(context)!.english,style: TextTheme.of(context).bodySmall,),
             ],),
           ),
         )

          ],),
     )
    );
  }
}*/
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/LanguageCubit/language_cubit.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/theme/common_widgets/Language_row.dart';

class AppLanguage extends StatefulWidget {
  const AppLanguage({super.key});

  @override
  State<AppLanguage> createState() => _AppLanguageState();
}

class _AppLanguageState extends State<AppLanguage> {
  @override
  Widget build(BuildContext context) {
    LanguageCubit cubit = BlocProvider.of<LanguageCubit>(context);

    return Scaffold(
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
                        ),
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.r),
                              topRight: Radius.circular(32.r),
                            ),
                            color: AppColors.White,
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
                              SizedBox(height: 16.h),
                              Text(
                                AppLocalizations.of(context)!.changelanguage,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 16.h),
                              LanguageRow(
                                title: AppLocalizations.of(context)!.arabic,
                                value: "ar",
                                selected: cubit.currentLanguage,
                                onChanged: (value) {
                                  cubit.changeLanguage("ar");
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 16.h),
                              LanguageRow(
                                title: AppLocalizations.of(context)!.english,
                                value: "en",
                                selected: cubit.currentLanguage,
                                onChanged: (value) {
                                  cubit.changeLanguage("en");
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetsManager.languageicon,
                          width: 15.w,
                          height: 15.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          cubit.currentLanguage == "en"
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ));
  }
}
