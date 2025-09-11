import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/order_items_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/api/models/product_model.dart';
part 'order_items_model.g.dart';

@JsonSerializable()
class OrderItems {
  @JsonKey(name: "product")
  final ProductModel? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? Id;
  OrderItems ({
    this.product,
    this.price,
    this.quantity,
    this.Id,
  });

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
  OrderItemsEntity toEntity() => OrderItemsEntity(
        product: product?.toEntity(),
        price: price,
        quantity: quantity,
        Id: Id,
      );
}
