import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_tab_bar.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/category_state.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoriesPage extends StatefulWidget {
  final int? catIndex;

  const CategoriesPage({super.key, this.catIndex});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            CustumSearchBar(),
            SliverToBoxAdapter(
              child: BlocBuilder<CategoriesViewModel, CategoryState>(
                builder: (context, state) {
                 

                  return CustumTabBar(
                    categoryList: state.categories ?? [],
                    produdctsList: state.products ?? [],
                    allProducts: state.allProducts!,
                    myIndex: state.index,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<CategoriesViewModel, CategoryState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return SizedBox(
                      height: 230.0,
                      child: Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.pink,
                          size: 50,
                        ),
                      ),
                    );
                  }

                  if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }

                  if (state.products != null && state.products!.isNotEmpty) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: state.products!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.details,
                              arguments: state.products![index],
                            );
                          },
                          child: CustomCardFlower(
                            productsEntity: state.products![index],
                          ),
                        );
                      },
                    );
                  } else {
                    return NoProducts();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
