import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/widgets/common_loading.dart';
import 'package:flutter/material.dart';


class CardImage extends StatelessWidget {
  final String productImage;
  const CardImage({
    super.key,
    required this.productImage
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl:
           productImage,
        width: 90.0,
        height: 100.0,
        fit: BoxFit.cover,
        placeholder: (context, _) => CommonLoading(),
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
