import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';

class HomeModel {
  HomeModel({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  HomeModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductsModel.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(CategoriesModel.fromJson(v));
      });
    }
    if (json['bestSeller'] != null) {
      bestSeller = [];
      json['bestSeller'].forEach((v) {
        bestSeller?.add(BestSellerModel.fromJson(v));
      });
    }
    if (json['occasions'] != null) {
      occasions = [];
      json['occasions'].forEach((v) {
        occasions?.add(OccasionsModel.fromJson(v));
      });
    }
  }
  String? message;
  List<ProductsModel>? products;
  List<CategoriesModel>? categories;
  List<BestSellerModel>? bestSeller;
  List<OccasionsModel>? occasions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (bestSeller != null) {
      map['bestSeller'] = bestSeller?.map((v) => v.toJson()).toList();
    }
    if (occasions != null) {
      map['occasions'] = occasions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  HomeEntity toEntity() {
    return HomeEntity(
      products: products?.map((product) => product.toEntity()).toList(),
      categories: categories?.map((category) => category.toEntity()).toList(),
      bestSeller: bestSeller?.map((bestSeller) => bestSeller.toEntity()).toList(),
      occasions: occasions?.map((occasion) => occasion.toEntity()).toList(),
    );
  }
}