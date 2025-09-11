import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';

// ignore: must_be_immutable
class CustumTabBar extends StatefulWidget {
  final List<CategoriesEntity> categoryList;
  final List<ProductsEntity> produdctsList;
  final List<ProductsEntity> allProducts;
   ValueNotifier<String> catId;

  final int? myIndex;

   CustumTabBar({
    super.key,
    required this.categoryList,
    required this.produdctsList,
    required this.allProducts,
    required this.catId,

    this.myIndex,
  });

  @override
  State<CustumTabBar> createState() => _CustumTabBarState();
}

class _CustumTabBarState extends State<CustumTabBar> {
  late final ValueNotifier<int> catIndex;

  @override
  void initState() {
    super.initState();

    CategoriesEntity allCategory = CategoriesEntity(id: "", name: "All");
    if (widget.categoryList.isEmpty || widget.categoryList[0].id != "") {
      widget.categoryList.insert(0, allCategory);
    }

    catIndex = ValueNotifier<int>(widget.myIndex ?? 0);

    final categoriesViewModel = context.read<CategoriesViewModel>();
    _sendEvent(categoriesViewModel, catIndex.value);
  }

  void _sendEvent(CategoriesViewModel categoriesViewModel, int index) {
    final selectedCategory = widget.categoryList[index];
    widget.catId.value = selectedCategory.id!;

    if (index == 0) {
      categoriesViewModel.add(
        GetAllProductsEvent(products: widget.allProducts),
      );
    } else {
      categoriesViewModel.add(
        GetAllProductsOfCategoriesEvent(
          catId: selectedCategory.id!,
          categories: widget.categoryList,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesViewModel = context.read<CategoriesViewModel>();

    return Padding(
      padding: const EdgeInsets.only(top: 10,),
      child: SizedBox(
        width: double.infinity,
        height: 30,
        child: ListView.builder(
          itemCount: widget.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () {
                  catIndex.value = index;

                  _sendEvent(categoriesViewModel, index);
                },
                child: ValueListenableBuilder<int>(
                  valueListenable: catIndex,
                  builder: (context, value, child) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: index == value
                                ? AppColors.pink
                                : AppColors.gray,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.categoryList[index].name!,
                        style: TextStyle(
                          fontSize: 16,
                          color: index == value
                              ? AppColors.pink
                              : AppColors.gray,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
