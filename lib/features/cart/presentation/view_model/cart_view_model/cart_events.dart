// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

abstract class CartEvents {}

class AddProductsToCart extends CartEvents {
  ProductsEntity product;
  AddProductsToCart({
    required this.product,
  });
  
}
