import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String imageUrl;

  const CacheImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.transparent,
      radius: (25),
      child: ClipOval(child: Image.asset(imageUrl)),
    );
  }
}
