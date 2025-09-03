import 'package:flower_e_commerce/features/cart/domain/entity/cart_item.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_model.g.dart';
@JsonSerializable()
class CartItemModel {
    @JsonKey(name: "product")
    ProductModel? product;
    @JsonKey(name: "price")
    int? price;
    @JsonKey(name: "quantity")
    int? quantity;
    @JsonKey(name: "_id")
    String? id;

    CartItemModel({
        this.product,
        this.price,
        this.quantity,
        this.id,
    });

    factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

    Map<String, dynamic> toJson() => _$CartItemModelToJson(this);


    CartItemEntity toEntity() => CartItemEntity(
        product: product?.toEntity(),
        price: price,
        quantity: quantity,
        id: id,
      );
}
