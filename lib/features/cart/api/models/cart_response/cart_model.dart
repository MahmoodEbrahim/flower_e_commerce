
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';
@JsonSerializable()
class CartModel {
    @JsonKey(name: "user")
    String? user;
    @JsonKey(name: "cartItems")
    List<CartItemModel>? cartItems;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "appliedCoupons")
    List<dynamic>? appliedCoupons;
    @JsonKey(name: "totalPrice")
    int? totalPrice;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
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
