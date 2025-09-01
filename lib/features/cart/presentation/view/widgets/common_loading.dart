import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.inkDrop(color: AppColors.Pink, size: 24));
  }
}
