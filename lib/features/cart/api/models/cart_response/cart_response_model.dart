
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_model.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cart_response_model.g.dart';

CartResponseDto cartResponseDtoFromJson(String str) => CartResponseDto.fromJson(json.decode(str));

String cartResponseDtoToJson(CartResponseDto data) => json.encode(data.toJson());

@JsonSerializable()
class CartResponseDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "numOfCartItems")
    int? numOfCartItems;
    @JsonKey(name: "cart")
    CartModel? cart;

    CartResponseDto({
        this.message,
        this.numOfCartItems,
        this.cart,
    });

    factory CartResponseDto.fromJson(Map<String, dynamic> json) => _$CartResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CartResponseDtoToJson(this);


      CartResponseEntity toEntity() => CartResponseEntity(
        message: message,
        numOfCartItems: numOfCartItems,
        cart: cart?.toEntity(),
      );
}


