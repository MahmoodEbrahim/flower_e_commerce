
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Widget child;

  const SearchBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray),
            borderRadius: BorderRadius.circular(8)),
        height: 50,
        child: child);
  }
}
