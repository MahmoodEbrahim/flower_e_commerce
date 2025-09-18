import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/core/widgets/delivery_location.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
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

class HomePage extends StatelessWidget {
  final void Function(CategoriesPageParameter)? onChangeTab;
  const HomePage({super.key, this.onChangeTab});

  @override
  Widget build(BuildContext context) {
    
    final categoriesViewModel = context.read<CategoriesViewModel>();
    final t = AppLocalizations.of(context)!;
    String location = "Lets go to add some addresses 😉";

    final LoginModel? loginModel = UserLocalStorage.getUser();
   
    if (loginModel != null) {
       UserModel userModel = loginModel.user;
        final List<AddressEntity> address = userModel.addresses;
        if (address.isNotEmpty) {
          location = " ${address[0].city} ${address[0].street}}";
        }
      
    }
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
                      color: AppColors.pink,
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
                      color: AppColors.pink,
                      size: 50,
                    ),
                  ],
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
                    DeliveryLocation(),

                      // Categories
                      buildSectionTitle(t.categories, () {
                        if (onChangeTab != null) {
                          onChangeTab!(CategoriesPageParameter(tabIndex: 1));
                        }
                      }, context),
                      buildCategoriesList(
                        homeData.categories,
                        onChangeTab,
                        categoriesViewModel,
                      ),

                      // Best Seller
                      buildSectionTitle(t.bestSeller, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bestSellers,
                          arguments: {
                            Constants.bestSeller: homeData.bestSeller,
                          },
                        );
                      }, context),
                      buildBestSellerList(homeData.bestSeller, context),

                      // Occasions
                      buildSectionTitle(t.occasion, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.occasions,
                          arguments: {Constants.occasions: homeData.occasions},
                        );
                      }, context),
                      buildOccasionsList(homeData.occasions),

                      // Products
                      buildSectionTitle(t.products, () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.allProducts,
                          arguments: {Constants.allProducts: homeData.products},
                        );
                      }, context),
                      buildProductsList(homeData.products, context),
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
