import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';
import 'package:flower_e_commerce/features/profile/api/models/generic_section_model.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/generic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/utils/json_helpers/json_loader.dart';

// class TermsAndConditionPage extends StatelessWidget {
//   final String locale;
//
//   const TermsAndConditionPage({super.key, this.locale = JsonKeys.en});
//
//   @override
//   Widget build(BuildContext context) {
//     final t = AppLocalizations.of(context)!;
//     final currentLocale = Localizations.localeOf(context).languageCode;
//
//     return FutureBuilder<Map<String, dynamic>>(
//       future: loadJson(JsonAssets.terms),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             backgroundColor: AppColors.white,
//             body: Center(
//               child: LoadingAnimationWidget.inkDrop(
//                 color: AppColors.pink,
//                 size: 50,
//               ),
//             ),
//           );
//         }
//
//         if (!snapshot.hasData || snapshot.data == null) {
//           return Center(child: Text(t.noDataFound));
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text(t.errorLoadingData));
//         }
//
//         final data = snapshot.data!;
//         final sectionsJsonRaw = data[JsonKeys.terms];
//         final sectionsJson = sectionsJsonRaw is List ? sectionsJsonRaw : null;
//
//         if (sectionsJson == null) {
//           return Center(child: Text(t.noSectionsFound));
//         }
//
//         final sections =
//             sectionsJson.map((e) => GenericSectionModel.fromJson(e)).toList();
//
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           body: Padding(
//             padding: const EdgeInsetsDirectional.only(top: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: sections
//                     .map((section) => buildGenericSection(section, locale))
//                     .toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context).languageCode; // <-- هنا

    return FutureBuilder<Map<String, dynamic>>(
      future: loadJson(JsonAssets.terms),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.pink,
                size: 50,
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text(t.noDataFound));
        }

        if (snapshot.hasError) {
          return Center(child: Text(t.errorLoadingData));
        }

        final data = snapshot.data!;
        final sectionsJsonRaw = data[JsonKeys.terms];
        final sectionsJson = sectionsJsonRaw is List ? sectionsJsonRaw : null;

        if (sectionsJson == null) {
          return Center(child: Text(t.noSectionsFound));
        }

        final sections =
        sectionsJson.map((e) => GenericSectionModel.fromJson(e)).toList();
        final firstSection = sections.first; // أول سيكشن
        final otherSections = sections.skip(1).toList();
        return Scaffold(
          extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
elevation: 0,

              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.transparent,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),),
          body: Padding(
            padding: const EdgeInsetsDirectional.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: sections
                    .map((section) => buildGenericSection(section, currentLocale)) // <-- هنا
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

