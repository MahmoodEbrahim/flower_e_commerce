

import '../../data/models/homemodel.dart';

class HomeEntity {
  final String? message;
  final List<Products>? products;
  final List<Categories>? categories;
  final List<BestSeller>? bestSeller;
  final List<Occasions>? occasions;

  HomeEntity({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });
}