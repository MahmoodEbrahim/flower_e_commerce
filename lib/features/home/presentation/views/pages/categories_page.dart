import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/common_widgets/custom_flower_card.dart';
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
    CategoriesEntity newCategory = CategoriesEntity(id: "", name: "All");
    widget.categoryList.insert(0, newCategory);
    categoriesViewModel
        .add(GetAllProductsEvent(products: widget.produdctsList));
    super.initState();
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
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.errorMessage != null) {
                            return Center(
                              child: Text(state.errorMessage!),
                            );
                          }
                          if (state.products != null &&
                              state.products!.isNotEmpty) {
                            final products = state.products!;

                            return SizedBox(
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
                                 
                                    return CustomCardFlower(
                                      image: products[index].imgCover ?? "",
                                      title: products[index].title ?? "",
                                      newPrice:
                                          products[index].priceAfterDiscount,
                                      oldPrice: products[index].price ?? 0,
                                    );
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
