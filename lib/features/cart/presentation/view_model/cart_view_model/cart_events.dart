// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
// import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

// abstract class CartEvents {}

// class AddProductsToCartEvent extends CartEvents {
//   ProductsEntity product;
//   AddProductsToCartEvent({
//     required this.product,
//   });
// }

// class IncreaseProductQuantityCartEvent extends CartEvents {
//   final CartEntity cartEntity;
//   IncreaseProductQuantityCartEvent({
//     required this.cartEntity,
//   });
// }

// class DecreaseProductQuantityCartEvent extends CartEvents {
//   CartEntity cartEntity;
//   DecreaseProductQuantityCartEvent({
//     required this.cartEntity,
//   });
// }

// class DeleteProductQuantityCartEvent extends CartEvents {
//   CartEntity cartEntity;
//   DeleteProductQuantityCartEvent({
//     required this.cartEntity,
//   });
// }

// class CalculateTotalCartEvent extends CartEvents {

// }

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
