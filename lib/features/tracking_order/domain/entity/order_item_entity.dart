
import 'package:flower_e_commerce/features/tracking_order/domain/entity/product_entity.dart';


class OrderItemEntity {
    ProductEntity product;
    int price;
    int quantity;
    String id;

    OrderItemEntity({
        required this.product,
        required this.price,
        required this.quantity,
        required this.id,
    });

  
}
