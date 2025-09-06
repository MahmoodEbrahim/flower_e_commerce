import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_color.dart';

class ProfileItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;

  const ProfileItem({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            if (leading != null) leading!,
            const SizedBox(width: 8),
            Text(
              title,
              style: getRegularStyle(
                color: AppColors.black,
                fontSize: FontSize.s16,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing!,
            if (showArrow)
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 20, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
