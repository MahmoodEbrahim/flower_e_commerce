import 'package:flower_e_commerce/features/home/data/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/data/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/data/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/data/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasions_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

class Homemodel {
  Homemodel({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  Homemodel.fromJson(dynamic json) {
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