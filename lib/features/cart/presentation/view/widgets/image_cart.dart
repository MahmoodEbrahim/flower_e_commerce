
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl:
            "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
        width: 90.0,
        height: 100.0,
        fit: BoxFit.cover,
        placeholder: (context, _) => Center(
            child: LoadingAnimationWidget.inkDrop(
                color: AppColors.Pink, size: 24)),
        errorWidget: (context, _, error) => Center(
          child: Icon(
            Icons.image_not_supported_rounded,
            color: AppColors.gray,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
