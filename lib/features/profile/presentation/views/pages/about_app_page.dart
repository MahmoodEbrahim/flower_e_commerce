import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/json_section/generic_json_section_bloc.dart';
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
      create: (_) => getIt<GenericJsonSectionBloc>()
        ..add(GenerateJsonSections(JsonAssets.aboutApp, JsonKeys.about)),
      child: Scaffold(
        body: BlocBuilder<GenericJsonSectionBloc, GenericJsonSectionStata>(
          builder: (context, state) {
            if (state.requestState == RequestState.loading) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: AppColors.pink,
                  size: 50,
                ),
              );
            } else if (state.requestState == RequestState.success) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    snap: true,
                    floating: true,
                    toolbarHeight: 60,
                    leadingWidth: 80,
                    leading:Padding(padding: EdgeInsetsDirectional.only(start: 20),
                      child:  IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios) ,
                      ),),
                    title:  JsonSectionBuilder(section: state.sections[0],
                        currentLang: currentLang),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final section = state.sections[index+1];
                          return JsonSectionBuilder(
                            section: section,
                            currentLang: currentLang,
                          );
                        },
                        childCount: (state.sections.length)-1,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.requestState == RequestState.error) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
