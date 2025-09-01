// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class CartEntity {
  ProductsEntity productModel;
  int stock;
  CartEntity({
    required this.productModel,
     this.stock=1,
  });
  

  CartEntity copyWith({
    ProductsEntity? productModel,
    int? stock,
  }) {
    return CartEntity(
      productModel: productModel ?? this.productModel,
      stock: stock ?? this.stock,
    );
  }
}
