// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

abstract class CategoriesEvent {}

class GetAllProductsOfCategoriesEvent extends CategoriesEvent {
  String catId;
  List<CategoriesEntity>? categories;
  int? index;
  GetAllProductsOfCategoriesEvent(
      {this.categories, required this.catId, this.index});
}

class GetAllProductsEvent extends CategoriesEvent {
  List<ProductsEntity> products;
  List<CategoriesEntity>? categories;
  List<ProductsEntity>? allproducts;


  GetAllProductsEvent({required this.products, this.categories,this.allproducts});
}

class SelectCatIndexEvent extends CategoriesEvent {
  int index;

  SelectCatIndexEvent({required this.index});
}
