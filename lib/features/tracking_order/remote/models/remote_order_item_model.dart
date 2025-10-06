import 'package:flower_e_commerce/core/utils/constants/json_serlizable_constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/order_item_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/remote/models/remote_product_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'remote_order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteOrderItemModel {
  @JsonKey(name: JsonSerlizableConstants.product)
RemoteProductModel? product;

@JsonKey(name: JsonSerlizableConstants.price)
int? price;

@JsonKey(name: JsonSerlizableConstants.quantity)
int? quantity;

@JsonKey(name: JsonSerlizableConstants.id)
String? id;


  RemoteOrderItemModel({this.product, this.price, this.quantity, this.id});

  factory RemoteOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOrderItemModelToJson(this);

   OrderItemEntity toEntity(
   
  ) {
    return OrderItemEntity(
      id: id ?? '',
      price: price ?? 0,
      quantity: quantity ?? 0,
      product: RemoteProductModel.toEntity(product),
    );
  }

 
  factory RemoteOrderItemModel.fromEntity(OrderItemEntity entity) {
    return RemoteOrderItemModel(
      id: entity.id,
      price: entity.price,
      quantity: entity.quantity,
      product: RemoteProductModel.fromEntity(entity.product),
    );
  }
}
