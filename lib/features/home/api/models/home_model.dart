import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<ProductModel>? products;
  @JsonKey(name: "categories")
  final List<CategoriesModel>? categories;
  @JsonKey(name: "bestSeller")
  final List<BestsellerModel>? bestSeller;
  @JsonKey(name: "occasions")
  final List<OccasionsModel>? occasions;

  HomeModel ({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$HomeModelToJson(this);
  }

  HomeEntity toEntity() {
    return HomeEntity(
      products: products?.map((product) => product.toEntity()).toList(),
      categories: categories?.map((category) => category.toEntity()).toList(),
      bestSeller: bestSeller?.map((bestSeller) => bestSeller.toEntity()).toList(),
      //occasions: occasions?.map((occasion) => occasion.toEntity()).toList(),
    );
  }
}




