import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flutter/material.dart';

class FilterButtom extends StatelessWidget {
  const FilterButtom({
    super.key,
    required this.categoriesViewModel,
    required this.filtersApi,
    required this.myIndex,
    required this.sendCatId,
  });

  final CategoriesViewModel categoriesViewModel;
  final List<String> filtersApi;
  final int myIndex;
  final String? sendCatId;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              categoriesViewModel.add(
                GetSearchProductsEvent(
                  filter: filtersApi[myIndex],
                  catId: sendCatId,
                ),
              );
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children:  [
                Icon(Icons.filter_alt_rounded),
                SizedBox(width: 5),
                Padding(padding: EdgeInsets.all(12.0), child: Text(t.filter)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
