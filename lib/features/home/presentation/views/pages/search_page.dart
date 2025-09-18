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
    final t = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => getIt<SearchBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  key: const Key('search_appbar'),
                  pinned: true,
                  floating: false,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  toolbarHeight: 70,
                  title: CustumSearchBar(
                    key: const Key('search_bar'),
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
                    key: const Key('loading_state'),
                    hasScrollBody: false,
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.pink,
                        size: 50,
                      ),
                    ),
                  )
                else if (state.requestState == RequestState.error)
                  SliverFillRemaining(
                    key: const Key('error_state'),
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 60, color: AppColors.midGray),
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage,
                            key: const Key('error_message'),
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
                else if (state.keyword.isEmpty || state.requestState == RequestState.init)
                    SliverFillRemaining(
                      key: const Key('empty_state'),
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/json/search.json",
                              fit: BoxFit.cover,
                              height: 150,
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    )

                  else if (state.products.isEmpty)
                      SliverFillRemaining(
                        key: const Key('no_results_state'),
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset("assets/json/no_search.json",
                                  height: 100.h,width: 200.w,fit: BoxFit.cover)
                           ,
                              const SizedBox(height: 39),
                              Text(
                                "${t.noProductsFor} ${state.keyword}",
                                key: const Key('no_results_message'),
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
                          key: const Key('success_results_state'),
                          padding: const EdgeInsets.all(8),
                          sliver: SliverGrid(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final product = state.products[index];
                                return GestureDetector(
                                  key: Key('product_card_$index'),
                                  child: CustomCardFlower(productsEntity: product),
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.details,
                                    arguments: product,
                                  ),
                                );
                              },
                              childCount: state.products.length,
                            ),
                          ),
                        ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
