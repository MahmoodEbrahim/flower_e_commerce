import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/assets_manger.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../view_models/tracking_map_view_model/tracking_map_event.dart';

class DeliverOrderInfo extends StatelessWidget {
  String deliveryGender;
  String deliveryName;
  String phone;
  DeliverOrderInfo({
    required this.deliveryGender,
    required this.deliveryName,
    required this.phone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            t.estimatedArrival,
            style: getMediumStyle(
              color: AppColors.gray,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

          child: Text(
            DateFormat('EEE, dd MMM yyyy, hh:mm a').format(DateTime.now()),
            style: getMediumStyle(
              color: AppColors.black,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        Divider(color: AppColors.whiteColor[70]),

        Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            children: [
              (deliveryGender == Constants.male)
                  ? SvgPicture.asset(
                      ImageAssets.deliveryBoy,
                      height: 50,
                      width: 50,
                    )
                  : Image.asset(
                      width: 50,
                      height: 50,
                      ImageAssets.deliveryGirl,
                    ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deliveryName,
                    style: getMediumStyle(
                      color: AppColors.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    t.deliveryHero,
                    style: getMediumStyle(
                      color: AppColors.gray,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
          onTap: () {
            if (phone != null) {
              context
                  .read<TrackingBloc>()
                  .add(
                CallUserEvent(
                  phone!,
                ),
              );
            }
          },
          child: Icon(
            Icons.call,
            color: AppColors.pink,
            size: 20,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            if (phone != null) {
              context
                  .read<TrackingBloc>()
                  .add(
                WhatsAppUserEvent(
                  phone
                ),
              );
            }
          },
          child: Icon(
            FontAwesomeIcons.whatsapp,
            color: AppColors.pink,
            size: 22,
          ),
        ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(t.orderDetails),
            ),
          ),
        ),
      ],
    );
  }
}
