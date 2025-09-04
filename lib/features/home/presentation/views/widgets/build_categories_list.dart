import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_page_parameter.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flutter/material.dart';

Widget buildCategoriesList(
    List<CategoriesEntity>? categories,
    void Function(CategoriesPageParameter)? onChangeTab,
    CategoriesViewModel catView) {
  if (categories == null || categories.isEmpty) {
    return const NoProducts();
  }
  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            catView.add(SelectCatIndexEvent(index: index+1));
            if (onChangeTab != null) {
              onChangeTab(
                  CategoriesPageParameter(tabIndex: 1, categoryIndex: index+1));
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.network(
                      category.image ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(category.name ?? '', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    ),
  );
}
