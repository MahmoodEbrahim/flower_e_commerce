
import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';
@JsonSerializable()
class CartModel {
    @JsonKey(name: JsonSerlizableConstants.user)
    String? user;
    @JsonKey(name: JsonSerlizableConstants.cartItemsKey)
    List<CartItemModel>? cartItems;
    @JsonKey(name: JsonSerlizableConstants.id)
    String? id;
    @JsonKey(name: JsonSerlizableConstants.appliedCouponsKey)
    List<dynamic>? appliedCoupons;
    @JsonKey(name: JsonSerlizableConstants.totalPriceKey)
    int? totalPrice;
    @JsonKey(name: JsonSerlizableConstants.createdAt)
    DateTime? createdAt;
    @JsonKey(name: JsonSerlizableConstants.updatedAtKey)
    DateTime? updatedAt;
    @JsonKey(name: JsonSerlizableConstants.vKey)
    int? v;

    CartModel({
        this.user,
        this.cartItems,
        this.id,
        this.appliedCoupons,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

    Map<String, dynamic> toJson() => _$CartModelToJson(this);

     CartEntity toEntity() => CartEntity(
        user: user,
        cartItems: cartItems?.map((e) => e.toEntity()).toList(),
        id: id,
        appliedCoupons: appliedCoupons,
        totalPrice: totalPrice,
  
        
      );
}
