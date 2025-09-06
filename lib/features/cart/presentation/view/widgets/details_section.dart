import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';

import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  final CartItemEntity cartItem;
  final int price;
  final CartViewModel cartViewModel = getIt.get<CartViewModel>();
  DetailsSection({super.key, required this.cartItem, required this.price});

  @override
  Widget build(BuildContext context) {
       final t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                cartItem.product!.title!,
                style: getBoldStyle(
                    color: AppColors.black, fontSize: FontSize.s16),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cartViewModel.add(
                        DeleteItemFromCartEvent(itemId: cartItem.product!.id!));
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.red,
                  )),
            )
          ],
        ),
        Text(
          cartItem.product!.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${t.egp} ${cartItem.price} ',
              style:
                  getBoldStyle(color: AppColors.black, fontSize: FontSize.s16),
            ),
            Row(
              children: [
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (cartItem.quantity! - 1 == 0) {
                        cartViewModel.add(DeleteItemFromCartEvent(
                            itemId: cartItem.product!.id!));
                      }
                      else{
                         final UpdatedQuatityRequestEntity
                          updatedQuatityRequestEntity =
                          UpdatedQuatityRequestEntity(
                              itemId: cartItem.product!.id!,
                              updatedRequestBody: UpdatedRequestBodyEntity(
                                  quantity: cartItem.quantity!-1));

                      cartViewModel.add(UpdateQuatityItemCEvent(
                          updatedReq: updatedQuatityRequestEntity));

                      }
                    
                    },
                    icon: Icon(Icons.remove)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "${cartItem.quantity}",
                    style: getBoldStyle(
                        color: AppColors.black, fontSize: FontSize.s16),
                  ),
                ),
                IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      final UpdatedQuatityRequestEntity
                          updatedQuatityRequestEntity =
                          UpdatedQuatityRequestEntity(
                              itemId: cartItem.product!.id!,
                              updatedRequestBody: UpdatedRequestBodyEntity(
                                  quantity: cartItem.quantity!+1));

                      cartViewModel.add(UpdateQuatityItemCEvent(
                          updatedReq: updatedQuatityRequestEntity));
                    },
                    icon: Icon(Icons.add)),
              ],
            )
          ],
        ),
      ],
    );
  }
}
