import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class CustumText extends StatelessWidget {
  final String primaryText;
  final String secondryText;
  final Color? color;
  final double? fontSize;
  final VoidCallback onTab;
  const CustumText({
    super.key,
    required this.primaryText,
    required this.secondryText,
    this.color,
    this.fontSize, required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: RichText(
          text: TextSpan(
              text: primaryText,
              style: TextStyle(fontSize: fontSize ?? FontSize.s14),
              children: [
            TextSpan(
                style:getBoldStyle(
                  
                  color: color ?? AppColors.Black,fontSize: fontSize??FontSize.s14).copyWith(decoration:TextDecoration.underline ),
                text: secondryText,
                recognizer: TapGestureRecognizer()..onTap = onTab)
          ])),
    );
  }
}

