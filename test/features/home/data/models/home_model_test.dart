import 'package:flower_e_commerce/features/home/data/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/data/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/data/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/data/models/home_model.dart';

void main() {
  group("Homemodel Test", () {
    test("fromJson should return valid Homemodel", () {
      // Arrange
      final json = {
        "categories": [
          {"_id": "1", "name": "Flowers", "image": "flowers.png"}
        ],
        "products": [
          {"_id": "101", "title": "Rose", "price": 50, "imgCover": "rose.png"}
        ],
        "bestSeller": [
          {"_id": "201", "title": "Tulip", "price": 70, "imgCover": "tulip.png"}
        ],
        "occasions": [
          {"_id": "301", "name": "Birthday", "image": "birthday.png"}
        ]
      };

      // Act
      final result = Homemodel.fromJson(json);

      // Assert
      expect(result, isA<Homemodel>());
      expect(result.categories?.first.name, "Flowers");
      expect(result.products?.first.title, "Rose");
      expect(result.bestSeller?.first.price, 70);
      expect(result.occasions?.first.name, "Birthday");
    });

    test("toJson should return valid Map", () {
      // Arrange
      final model = Homemodel(
        categories: [
          CategoriesModel(id: "1", name: "Flowers", image: "flowers.png")
        ],
        products: [
          ProductsModel(id: "101", title: "Rose", price: 50, imgCover: "rose.png")
        ],
        bestSeller: [
          BestSellerModel(id: "201", title: "Tulip", price: 70, imgCover: "tulip.png")
        ],
        occasions: [
          OccasionsModel(id: "301", name: "Birthday", image: "birthday.png")
        ],
      );

      // Act
      final result = model.toJson();

      // Assert
      expect(result["categories"], isNotNull);
      expect(result["products"], isNotNull);
      expect(result["bestSeller"], isNotNull);
      expect(result["occasions"], isNotNull);
    });
  });
}
