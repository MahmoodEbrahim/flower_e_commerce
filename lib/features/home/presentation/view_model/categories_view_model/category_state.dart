// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';




class CategoryState extends Equatable {
  final bool isLoading;
  final List<ProductsEntity>? products;
  final List<CategoriesEntity>? categories;
  final String? errorMessage;
  
  const CategoryState({
    this.isLoading = true,
    this.products,
    this.errorMessage,
    this.categories
  });

  @override

List<Object?> get props => [isLoading, products, errorMessage, categories];


  CategoryState copyWith({
    bool? isLoading,
    List<ProductsEntity>? products,
    String? errorMessage,
      List<CategoriesEntity>? categories
  }) {
    return CategoryState(
    isLoading: isLoading ?? this.isLoading,
    products: products ?? this.products,
    errorMessage: errorMessage ?? this.errorMessage,
    categories: categories ?? this.categories,
  );
  }
}
