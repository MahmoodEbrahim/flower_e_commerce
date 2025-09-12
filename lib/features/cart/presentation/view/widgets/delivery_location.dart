import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter/material.dart';

// class DeliveryLocation extends StatelessWidget {
//   const DeliveryLocation({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//        final t = AppLocalizations.of(context)!;
//        final addresses = UserModel().addresses;
//        final addressList = (addresses != null && addresses.isNotEmpty)
//            ? addresses as List<AddressEntity>
//            : <AddressEntity>[];
//        final city=addressList[0].city;
//        final street=addressList[0].street;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Expanded(flex: 2, child: Icon(Icons.location_on_outlined)),
//         Expanded(
//           flex: 18,
//           child: RichText(
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             text: TextSpan(
//               text: t.deliver_to,
//               style: getRegularStyle(color: AppColors.black,fontSize: FontSize.s14),
//               children: [
//                 TextSpan(
//                   text:
//                   addresses==null &&addressList.isEmpty?        t.bigAddress:"${city}  ${street}",
//                   style: getBoldStyle(color: AppColors.black,fontSize: FontSize.s16),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//             flex: 2,
//             child: IconButton(
//                 onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down,)))
//       ],
//     );
//   }
// }
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter/material.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final addresses = UserModel().addresses;
    print(addresses);
    final addressList = (addresses != null && addresses.isNotEmpty)
        ? addresses as List<AddressEntity>
        : <AddressEntity>[];

    // Check if addressList is not empty before accessing its elements
    final displayText = addressList.isNotEmpty
        ? "${addressList[0].city} ${addressList[0].street}"
        : t.bigAddress;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Icon(Icons.location_on_outlined)),
        Expanded(
          flex: 18,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: t.deliver_to,
              style: getRegularStyle(color: AppColors.black, fontSize: FontSize.s14),
              children: [
                TextSpan(
                  text: displayText,
                  style: getBoldStyle(color: AppColors.black, fontSize: FontSize.s16),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}
