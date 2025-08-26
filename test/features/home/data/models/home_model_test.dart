import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

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
          Categories(id: "1", name: "Flowers", image: "flowers.png")
        ],
        products: [
          Products(id: "101", title: "Rose", price: 50, imgCover: "rose.png")
        ],
        bestSeller: [
          BestSeller(id: "201", title: "Tulip", price: 70, imgCover: "tulip.png")
        ],
        occasions: [
          Occasions(id: "301", name: "Birthday", image: "birthday.png")
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
