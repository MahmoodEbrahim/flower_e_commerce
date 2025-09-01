// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class CartStates {
  String? errorMessage;
  bool isLoading;
  List<ProductsEntity> products;
  CartStates({
    this.errorMessage,
    this.isLoading=true,
     this.products=const  [],
  });



  CartStates copyWith({
    String? errorMessage,
    bool? isLoading,
    List<ProductsEntity>? products,
  }) {
    return CartStates(
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
