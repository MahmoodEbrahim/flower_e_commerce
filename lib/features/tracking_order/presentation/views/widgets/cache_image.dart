import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {

  const CacheImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: (25),
     
      child: ClipOval(
        child: Image.asset(AssetsManager.delivaryBoyImage)
       
      ),
    );
  }
}