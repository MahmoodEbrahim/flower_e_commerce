import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WaitingForConfirmation extends StatefulWidget {
  const WaitingForConfirmation({super.key});

  @override
  State<WaitingForConfirmation> createState() => _WaitingForConfirmationState();
}

class _WaitingForConfirmationState extends State<WaitingForConfirmation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: child,
              );
            },
            child: FaIcon(
              FontAwesomeIcons.motorcycle,
              size: 130,
              color: AppColors.pink,
            ),
          ),

          const SizedBox(height: 40),

          Text(
            translate.waitingForDeliveryHero,
            textAlign: TextAlign.center,
            style: getBoldStyle(
              color: AppColors.blackColor[50]!,
              fontSize: FontSize.s24,
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
