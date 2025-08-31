import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_best_seller_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_categories_list.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_states.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_occasions_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_products_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/di/di.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              BlocProvider.of<HomeBloc>(context).add(GetHomeDataEvent());
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 230.0),
                    LoadingAnimationWidget.inkDrop(
                      color: AppColors.Pink,
                      size: 50,
                    ),
                  ],
                ),
              );
            } else if (state is HomeLoadingState) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 230.0),
                    LoadingAnimationWidget.inkDrop(
                      color: AppColors.Pink,
                      size: 50,
                    ),
                  ],
                ),
              );
            } else if (state is HomeErrorState) {
              return Center(child: Text('${t.error}: ${state.message}'));
            } else if (state is HomeSuccessState) {
              final homeData = state.homeResponse;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text(
                              t.appTitle,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                                fontFamily: "IMFellEnglish",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: t.search,
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Location
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 24),
                          const SizedBox(width: 6),
                           Text(
                            t.address,
                            style: TextStyle(fontSize: 18),
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined,
                              size: 24, color: Colors.pink),
                        ],
                      ),

                      // Categories
                      buildSectionTitle(t.categories, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.catergories,
                          arguments: {
                            Constants.catList: homeData.categories,
                            Constants.productList: homeData.products,
                          },
                        );
                      },context),
                      buildCategoriesList(homeData.categories),

                      // Best Seller
                      buildSectionTitle(t.bestSeller, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bestSellers,
                          arguments: {
                            Constants.bestSeller: homeData.bestSeller,
                          },
                        );
                      },context),
                      buildBestSellerList(homeData.bestSeller, context),

                      // Occasions
                      buildSectionTitle(t.occasion, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.occasions,
                          arguments: {
                            Constants.occasions: homeData.occasions,
                          },
                        );
                      },context),
                      buildOccasionsList(homeData.occasions),

                      // Products
                      buildSectionTitle(t.products, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allProducts,
                          arguments: {
                            Constants.allProducts: homeData.products,
                          },
                        );
                      },context),
                      buildProductsList(homeData.products,context),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
