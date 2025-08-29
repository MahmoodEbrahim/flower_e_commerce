import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';


class HomeEntity {
  final List<ProductsEntity>? products;
  final List<CategoriesEntity>? categories;
  final List<BestSellerEntity>? bestSeller;
   List<OccasionsEntity>? occasions;

  HomeEntity({
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });
}