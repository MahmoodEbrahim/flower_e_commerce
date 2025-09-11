import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';

abstract class CartEvents {}

class AddToCartEvent extends CartEvents {
  final CartItemRequestEntity cartItemRequestEntity;
  AddToCartEvent({
    required this.cartItemRequestEntity,
  });
}

class GetCartItemsEvent extends CartEvents {}

class DeleteItemFromCartEvent extends CartEvents {
  final String itemId;
  DeleteItemFromCartEvent({
    required this.itemId,
  });
  
}
class UpdateQuatityItemCEvent extends CartEvents {
  final UpdatedQuatityRequestEntity updatedReq;
  UpdateQuatityItemCEvent({
    required this.updatedReq,
  });

}
