import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/category_state.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_search_bar.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custum_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoriesPage extends StatefulWidget {
  final List<CategoriesEntity> categoryList;
  final List<ProductsEntity> produdctsList;

  const CategoriesPage(
      {super.key, required this.categoryList, required this.produdctsList});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesViewModel categoriesViewModel =
      getIt.get<CategoriesViewModel>();

  @override
  void initState() {
    super.initState();

    final hasAllCategory = widget.categoryList.any((cat) => cat.name == "All");

    if (!hasAllCategory) {
      CategoriesEntity newCategory = CategoriesEntity(id: "", name: "All");
      widget.categoryList.insert(0, newCategory);
    }

    categoriesViewModel
        .add(GetAllProductsEvent(products: widget.produdctsList));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: categoriesViewModel,
      child: Scaffold(
        backgroundColor: AppColors.White,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: [
              CustumSearchBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      CustumTabBar(
                          categoryList: widget.categoryList,
                          categoriesViewModel: categoriesViewModel,
                          produdctsList: widget.produdctsList),
                      BlocBuilder<CategoriesViewModel, CategoryState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 230.0,
                                ),
                                LoadingAnimationWidget.inkDrop(
                                    color: AppColors.Pink, size: 50)
                              ],
                            );
                          }
                          if (state.errorMessage != null) {
                            return Center(
                              child: Text(state.errorMessage!),
                            );
                          }
                          if (state.products != null) {
                            final products = state.products!;

                            return state.products!.isEmpty
                                ? NoProducts()
                                : SizedBox(
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 0.6,
                                        ),
                                        itemCount: products.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    AppRoutes.details,arguments: products[index]);
                                              },
                                              child: CustomCardFlower(
                                                image:
                                                    products[index].imgCover ??
                                                        "",
                                                title:
                                                    products[index].title ?? "",
                                                newPrice: products[index]
                                                    .priceAfterDiscount,
                                                oldPrice:
                                                    products[index].price ?? 0,
                                              ));
                                        }),
                                  );
                          } else {
                            return Center(
                              child: Text(t.noProducts),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
