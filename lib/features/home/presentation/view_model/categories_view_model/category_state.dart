// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final List<ProductModel>? products;
  final String? errorMessage;
  const CategoryState({
    this.isLoading = true,
    this.products,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [isLoading, products, errorMessage];

  CategoryState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      products: products , 
      errorMessage: errorMessage 
    );
  }
}
