import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/generic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../core/l10n/translations/app_localizations.dart';
import '../../../../../core/utils/json_helpers/json_loader.dart';
import '../../../api/models/generic_section_model.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context).languageCode; // 👈 اللغة الحالية

    return FutureBuilder<Map<String, dynamic>>(
      future: loadJson(JsonAssets.aboutUs),
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

        if (snapshot.hasError) {
          return Center(child: Text(t.errorLoadingData));
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text(t.noDataFound));
        }

        final data = snapshot.data!;
        final sectionsJson = data[JsonKeys.about] as List<dynamic>?;
        if (sectionsJson == null) {
          return Center(child: Text(t.noSectionsFound));
        }

        final sections = sectionsJson
            .map((e) => GenericSectionModel.fromJson(e as Map<String, dynamic>))
            .toList();

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
                    .map((section) => buildGenericSection(section, currentLocale)) // 👈 اللغة بتتحدد أوتوماتيك
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
