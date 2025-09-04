import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustumTabBar extends StatefulWidget {
  final List<CategoriesEntity> categoryList;
  final List<ProductsEntity> produdctsList;

  const CustumTabBar({
    super.key,
    required this.categoryList,
    required this.produdctsList,
  });

  @override
  State<CustumTabBar> createState() => _CustumTabBarState();
}

class _CustumTabBarState extends State<CustumTabBar> {
  final ValueNotifier<int> catIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final categoriesViewModel = context.read<CategoriesViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                  categoriesViewModel.add(
                    GetAllProductsOfCategoriesEvent(
                      catId: widget.categoryList[index].id!,
                      categories: widget.categoryList,
                    ),
                  );
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
                        style: getRegularStyle(
                          fontSize: FontSize.s16,
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
