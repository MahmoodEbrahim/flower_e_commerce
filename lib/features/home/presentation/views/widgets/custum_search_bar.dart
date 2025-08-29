import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/search_box.dart';
import 'package:flutter/material.dart';

class CustumSearchBar extends StatelessWidget {
  const CustumSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return
      SliverAppBar(
        toolbarHeight: 30,
        backgroundColor: AppColors.White,
        centerTitle: false,
        pinned: false,
        floating: true,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,

        flexibleSpace: FlexibleSpaceBar(
          background: Container(color: Colors.transparent),
          collapseMode: CollapseMode.none,
          titlePadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(flex: 1,
                  child: IconButton(onPressed: (Navigator.of(context).pop), icon: Icon(Icons.arrow_back))),
              Expanded(
                  flex: 4,
                  child: SearchBox(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        border: InputBorder.none,
                        iconColor: AppColors.gray,
                        hintText: t.search,
                        hintStyle: TextStyle(color: AppColors.gray),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: SearchBox(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.gray,
                        )),
                  ))
            ],
          ),
        ),
      );
  }
}