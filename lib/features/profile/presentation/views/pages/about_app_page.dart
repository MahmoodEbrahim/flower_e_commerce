import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/about_app/generic_json_section_bloc.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/widgets/json_section_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) => getIt<GenericJsonSectionBloc>()..add(GenerateJsonSections(JsonAssets.aboutApp,JsonKeys.about)),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent,),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<GenericJsonSectionBloc, GenericJsonSectionStata>(
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return  Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 230.0),
                    LoadingAnimationWidget.inkDrop(
                      color: AppColors.pink,
                      size: 50,
                    ),
                  ],
                ),
              );
            } else if (state.requestState == RequestState.success) {
              return ListView.builder(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15,vertical: 35),
                itemCount: state.sections.length,
                itemBuilder: (context, index) {
                  final section = state.sections[index];
                  return JsonSectionBuilder(
                    section: section,
                    currentLang: currentLang,
                  );
                },
              );
            } else if (state.requestState == RequestState.error) {
              print(state.errorMessage);
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
