import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_page_parameter.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_best_seller_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_categories_list.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_states.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_occasions_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_products_list.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/build_section_title.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/di/di.dart';
import '../../../../auth/presentation/view_model/user_session_view_model/user_session_bloc.dart';
import '../../../../auth/presentation/view_model/user_session_view_model/user_session_state.dart';

class HomePage extends StatelessWidget {
  final void Function(CategoriesPageParameter)? onChangeTab;
  const HomePage({super.key, this.onChangeTab});

  @override
  Widget build(BuildContext context) {
    final categoriesViewModel = context.read<CategoriesViewModel>();
    final t = AppLocalizations.of(context)!;

    // لو محتاج location من الـ user profile API، هنا مؤقت
    String city = "";
    String street = "";

    return BlocBuilder<UserSessionBloc, UserSessionState>(
        builder: (context, userState) {
          if (userState.status == UserSessionStatus.unauthenticated) {
            // المستخدم غير مسجل دخول
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "t.youAreNotLoggedIn",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: Text("t.goToLogin"),
                  ),
                ],
              ),
            );
          }

          // المستخدم مسجل دخول أو الحالة قيد التحميل
          return BlocProvider(
              create: (context) => getIt<HomeBloc>()..add(GetHomeDataEvent()),
              child: BlocBuilder<HomeBloc, HomeStates>(
                  builder: (context, state) {
                    if (state is HomeLoadingState || state is HomeInitialState) {
                      return Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.pink,
                          size: 50,
                        ),
                      );
                    } else if (state is HomeErrorState) {
                      return Center(child: Text('${t.error}: ${state.message}'));
                    } else if (state is HomeSuccessState) {
                      final homeData = state.homeResponse;

                      categoriesViewModel.add(
                        GetAllProductsEvent(
                          products: homeData.products!,
                          categories: homeData.categories!,
                          allproducts: homeData.products!,
                        ),
                      );

                      return SingleChildScrollView(
                          padding: const EdgeInsets.all(12),
                          child: SafeArea(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            /// Header + Search
                            Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(
                                  t.appTitle,
                                  style: GoogleFonts.imFellEnglish(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: CustumSearchBar(readOnly: true),
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
                              Expanded(
                                child: Text(
                                  city.isEmpty && street.isEmpty
                                      ? "t.noLocation"
                                      : "$city $street",
                                  style: const TextStyle(fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 24,
                                color: Colors.pink,
                              ),
                            ],
                          ),

                          // Categories
                          buildSectionTitle(
                              t.categories,
                                  () {
                                onChangeTab?.call(
                                    CategoriesPageParameter(tabIndex: 1));
                              },
                            context,
                          ),
                                  buildCategoriesList(
                                      homeData.categories, onChangeTab, categoriesViewModel),

                                  // Best Seller
                                  buildSectionTitle(
                                    t.bestSeller,
                                        () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.bestSellers,
                                        arguments: {'bestSeller': homeData.bestSeller},
                                      );
                                    },
                                    context,
                                  ),
                                  buildBestSellerList(homeData.bestSeller, context),

                                  // Occasions
                                  buildSectionTitle(
                                    t.occasion,
                                        () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.occasions,
                                        arguments: {'occasions': homeData.occasions},
                                      );
                                    },
                                    context,
                                  ),
                                  buildOccasionsList(homeData.occasions),

                                  // Products
                                  buildSectionTitle(
                                    t.products,
                                        () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.allProducts,
                                        arguments: {'allProducts': homeData.products},
                                      );
                                    },
                                    context,
                                  ),
                                  buildProductsList(homeData.products, context),
                                ],
                            ),
                          ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
              ),
          );
        },
    );
  }}
