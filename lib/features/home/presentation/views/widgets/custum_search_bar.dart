import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/search_view_model/search_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustumSearchBar extends StatelessWidget {
  final bool readOnly;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final TextEditingController? controller;

  const CustumSearchBar({
    super.key,
    required this.readOnly,
    this.suffixIcon,
    this.onPressed,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      children: [
      
        SearchBox(
          child: TextField(
            controller: controller,
            onTap: () {
              if (readOnly) {
                Navigator.pushNamed(context, AppRoutes.search);
              }
            },
            onChanged: (keyword) {
              if (keyword.isEmpty) {
                context.read<SearchBloc>().add(ClearSearch());
              } else {
                context.read<SearchBloc>().add(SearchProductsEvent(keyword));
              }
            },
            readOnly: readOnly,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              iconColor: AppColors.gray,
              prefixIcon: Icon(Icons.search_outlined,color:AppColors.whiteColor[70]),
              hintText: t.search,
              hintStyle: TextStyle(color: AppColors.whiteColor[70]),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(suffixIcon, color:AppColors.whiteColor[70],size:30),
                    )
                  : null,
            ),
          ),
        ),

      
      ],
    );
  }
}
