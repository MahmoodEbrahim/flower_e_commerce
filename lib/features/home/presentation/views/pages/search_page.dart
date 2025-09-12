import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/search_view_model/search_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../../../../../config/theme/app_color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t=AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => getIt<SearchBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  toolbarHeight: 70,
                  title: CustumSearchBar(
                    controller: _controller,
                    readOnly: false,
                    suffixIcon: Icons.cancel_outlined,
                    onPressed: () {
                      _controller.clear();
                      context.read<SearchBloc>().add(ClearSearch());
                    },
                  ),
                ),

                if (state.requestState == RequestState.loading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        LoadingAnimationWidget.inkDrop(
                          color: AppColors.pink,
                          size: 50,
                        ),
                      ],
                    ),
                  )
                else if (state.requestState == RequestState.error)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 60,
                            color: AppColors.midGray,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                            style: getMediumStyle(
                              color: AppColors.midGray,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state.keyword.isEmpty|| state.requestState==RequestState.init)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                       Lottie.asset("assets/json/search.json",fit: BoxFit.cover,
                       height: 150.h,width: 200.w
                       ),
                          const SizedBox(height: 12),
                          Text(
                            t.typeSomething,
                            textAlign: TextAlign.center,
                            style: getMediumStyle(
                              color: AppColors.midGray,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state.products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.sentiment_very_dissatisfied,
                            size: 40,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${t.noProductsFor} ${state.keyword}",
                            style: getMediumStyle(
                              color: AppColors.midGray,
                              fontSize: FontSize.s18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state.products.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = state.products[index];
                        return GestureDetector(
                          child: CustomCardFlower(productsEntity: product),
                          onTap: () => Navigator.pushNamed(context, AppRoutes.details,arguments: product),
                        );
                      }, childCount: state.products.length),
                    ),
                  ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
