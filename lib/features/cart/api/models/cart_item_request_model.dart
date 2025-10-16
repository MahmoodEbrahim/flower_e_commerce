import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_request_model.g.dart';

@JsonSerializable()
class CartItemRequestModel extends Equatable {
  @JsonKey(name: JsonSerlizableConstants.productKey)
  final String? product;
  @JsonKey(name: JsonSerlizableConstants.quantityKey)
  final int? quantity;

  const CartItemRequestModel({
    this.product,
    this.quantity,
  });

  factory CartItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemRequestModelToJson(this);

  static CartItemRequestModel toModel(CartItemRequestEntity entity) {
    return CartItemRequestModel(
      product: entity.product,
      quantity: entity.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
