import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

void main() {
  group("ProductModel toEntity", () {
    test("should correctly convert ProductModel to ProductsEntity", () {
      // Arrange
      final model = ProductModel(
        id: "p1",
        iid: "iid1",
        title: "Red Rose",
        slug: "red-rose",
        description: "Beautiful red rose bouquet",
        imgCover: "red_rose.png",
        images: ["img1.png", "img2.png"],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 10,
        category: "flowers",
        occasion: "valentine",
        rateAvg: 5,
        rateCount: 100,
        createdAt: "2025-09-16",
        updatedAt: "2025-09-16",
        v: 1,
        isSuperAdmin: false,
        sold: 50,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<ProductsEntity>());
      expect(entity.id, "p1");
      expect(entity.title, "Red Rose");
      expect(entity.description, "Beautiful red rose bouquet");
      expect(entity.imgCover, "red_rose.png");
      expect(entity.images, ["img1.png", "img2.png"]);
      expect(entity.price, 200);
      expect(entity.priceAfterDiscount, 150);
      expect(entity.quantity, 10);
      expect(entity.category, "flowers");
      expect(entity.occasion, "valentine");
    });

    test("should handle null fields gracefully", () {
      // Arrange
      final model = ProductModel();

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, isNull);
      expect(entity.title, isNull);
      expect(entity.description, isNull);
      expect(entity.imgCover, isNull);
      expect(entity.images, isNull);
      expect(entity.price, isNull);
      expect(entity.priceAfterDiscount, isNull);
      expect(entity.quantity, isNull);
      expect(entity.category, isNull);
      expect(entity.occasion, isNull);
    });
  });
}
