// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';

class CategoryState {
   bool isLoading;
   List<ProductModel>? products;
   String? errorMessage;
  CategoryState({
     this.isLoading=false,
     this.products,
     this.errorMessage,
});




  CategoryState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      products: products??  this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
