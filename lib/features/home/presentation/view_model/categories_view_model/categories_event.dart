// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';

abstract class CategoriesEvent {}

class GetAllProductsOfCategoriesEvent extends CategoriesEvent {
  String catId;
  GetAllProductsOfCategoriesEvent({
    required this.catId,
  });
}

class GetAllProductsEvent extends CategoriesEvent {
  List<ProductModel> products;
  GetAllProductsEvent({
    required this.products,
  });
  
}
