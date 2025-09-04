import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/custom_flower_card.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCategory extends StatefulWidget {
  final String catId;
  final String catName;
  const  ProductsCategory({super.key, required this.catId,required this.catName});

  @override
  State<ProductsCategory> createState() => _ProductsCategoryState();
}

class _ProductsCategoryState extends State<ProductsCategory> {
  final CategoriesViewModel categoriesViewModel =
  getIt.get<CategoriesViewModel>();

  @override
  void initState() {
    // categoriesViewModel
    //     .add(GetAllProductsOfCategoriesEvent(catId: widget.catId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: categoriesViewModel,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 50,
                backgroundColor: AppColors.white,
                pinned: false,
                floating: true,
                centerTitle: false,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                 widget.catName,
                  style: TextStyle(color: AppColors.black),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
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
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoutes.details,
                                              arguments: products[index]);
                                        },
                                        child: CustomCardFlower(
                                        productsEntity: products[index],
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