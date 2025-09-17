import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/bottom_sheet_title.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/dragable_line.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustumBootomSheet extends StatefulWidget {
  final ValueNotifier<String> catId;
  final ValueNotifier<String?> selectedValue;
  final BuildContext mycontext;
  final AppLocalizations t;

  const CustumBootomSheet({
    super.key,
    required this.catId,
    required this.mycontext,
    required this.selectedValue,
    required this.t,
  });

  @override
  State<CustumBootomSheet> createState() => _CustumBootomSheetState();
}

class _CustumBootomSheetState extends State<CustumBootomSheet> {
  late   AppLocalizations local=widget.t;
  late CategoriesViewModel categoriesViewModel;
  late String? mySelectedValue;

   late List<String> options = [
    local.lowerPrice,
    local.highestPrice,
    local.newFilter,
    local.old,
    local.discount,
  ];
  final List<String> filtersApi = [Constants.price, Constants.lowPrice, Constants.myNew, Constants.old, Constants.discount];
  int myIndex = 0;
  String? sendCatId;

  @override
  void initState() {
    super.initState();
    mySelectedValue = widget.selectedValue.value;

    categoriesViewModel = widget.mycontext.read<CategoriesViewModel>();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        key: Key("padding at custumBottomSheet"),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DraagableLine(),
      
            ButtomSheetTitle(),
      
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  String value = options[index];
      
                  return
                   Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
      
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor[10]!,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: AppColors.whiteColor[10],
                    ),
                    child: RadioListTile<String>(
                      key: Key("firstTile $index"),
                      fillColor: WidgetStateProperty.all(AppColors.pink),
                      value: value,
                      selected: true,
                      groupValue: mySelectedValue,
                      onChanged: (val) {
                        setState(() {
                          mySelectedValue = val;
                          widget.selectedValue.value = val;
                          myIndex = index;
                          if (widget.catId.value == "") {
                            sendCatId = null;
                          } else {
                            sendCatId = widget.catId.value;
                          }
                        });
                      },
                      title: Text(
                        value,
                        style: getBoldStyle(
                          color: AppColors.black,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  );
               
               
                },
              ),
            ),
      
            SizedBox(height: 10),
      
            FilterButtom(categoriesViewModel: categoriesViewModel, filtersApi: filtersApi, myIndex: myIndex, sendCatId: sendCatId),
          ],
        ),
      ),
    );
  }
}

