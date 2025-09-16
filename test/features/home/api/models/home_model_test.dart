import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/home_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

void main() {
  group("HomeModel toEntity", () {
    test("should correctly convert HomeModel with data to HomeEntity", () {
      // Arrange - fake models
      final productModel = ProductModel(
        iid: "1",
        title: "Test Product",
        slug: "test-product",
        description: "desc",
        imgCover: "cover.png",
        images: ["img1.png"],
        quantity: 10,
        category: "cat1",
        occasion: "occ1",
        isSuperAdmin: false,
      );

      final categoryModel = CategoriesModel(
        iid: "cat1",
        name: "Flowers",
        slug: "flowers",
        image: "cat.png",
      );

      final bestSellerModel = BestsellerModel(
        iid: "b1",
        title: "Best Seller Product",
        slug: "best-seller-product",
        description: "best desc",
        imgCover: "best.png",
        images: ["best1.png"],
        price: 350,
      );

      final occasionModel = OccasionsModel(
        iid: "occ1",
        name: "Birthday",
        slug: "birthday",
        image: "birthday.png",
      );

      final homeModel = HomeModel(
        message: "success",
        products: [productModel],
        categories: [categoryModel],
        bestSeller: [bestSellerModel],
        occasions: [occasionModel],
      );

      // Act
      final result = homeModel.toEntity();

      // Assert
      expect(result, isA<HomeEntity>());

      /// products
      expect(result.products?.length, 1);
      expect(result.products?.first.title, "Test Product");
      expect(result.products?.first.imgCover, "cover.png");

      /// categories
      expect(result.categories?.length, 1);
      expect(result.categories?.first.name, "Flowers");

      /// best sellers
      expect(result.bestSeller?.length, 1);
      expect(result.bestSeller?.first.title, "Best Seller Product");
      expect(result.bestSeller?.first.price, 350);

      /// occasions
      expect(result.occasions?.length, 1);
      expect(result.occasions?.first.slug, isNull);
      expect(result.occasions?.first.name, "Birthday");
    });

    test("should return empty lists in HomeEntity when HomeModel lists are null", () {
      // Arrange
      final homeModel = HomeModel(
        message: "empty",
        products: null,
        categories: null,
        bestSeller: null,
        occasions: null,
      );

      // Act
      final result = homeModel.toEntity();

      // Assert
      expect(result.products, isNull);
      expect(result.categories, isNull);
      expect(result.bestSeller, isNull);
      expect(result.occasions, isNull);
    });
  });
}
