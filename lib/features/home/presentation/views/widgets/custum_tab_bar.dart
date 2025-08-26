import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/features/home/domain/entity/category_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flutter/material.dart';

class CustumTabBar extends StatelessWidget {
  final List<CategoryModel> categoryList;
  final CategoriesViewModel categoriesViewModel;
  final List<ProductModel> produdctsList;

  CustumTabBar(
      {super.key,
      required this.categoryList,
      required this.categoriesViewModel,
      required this.produdctsList});
  final ValueNotifier<int> catIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: InkWell(
                onTap: () {
                  catIndex.value = index;
                  // get all products if index=0
                  if (catIndex.value == 0) {
                    categoriesViewModel
                        .add(GetAllProductsEvent(products: produdctsList));
                      
                  }
                  else{
                     categoriesViewModel
                        .add(GetAllProductsOfCategoriesEvent(catId: categoryList[catIndex.value].id!));

                  }

                  // get category products

                
                },
                child: ValueListenableBuilder(
                    valueListenable: catIndex,
                    builder: (context, value, child) {
                      return Container(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: index == catIndex.value
                                      ? AppColors.Pink
                                      : AppColors.midGray,
                                  width: 2)),
                        ),
                        child: Text(
                          categoryList[index].name!,
                          style: getRegularStyle(
                            fontSize: FontSize.s16,
                              color: index == catIndex.value
                                  ? AppColors.Pink
                                  : AppColors.midGray),
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}
