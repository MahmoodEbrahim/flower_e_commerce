import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';

void main() {
  group("BestsellerModel toEntity", () {
    test("should correctly convert BestsellerModel to BestSellerEntity", () {
      // Arrange
      final model = BestsellerModel(
        id: "123",
        iid: "b1",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "Beautiful red roses",
        imgCover: "rose.png",
        images: ["img1.png", "img2.png"],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 10,
        category: "flowers",
        occasion: "valentine",
        rateAvg: 5,
        rateCount: 12,
        createdAt: "2025-09-16",
        updatedAt: "2025-09-16",
        v: 1,
        isSuperAdmin: false,
        sold: 20,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<BestSellerEntity>());
      expect(entity.id, "123");
      expect(entity.title, "Rose Bouquet");
      expect(entity.description, "Beautiful red roses");
      expect(entity.imgCover, "rose.png");
      expect(entity.images, ["img1.png", "img2.png"]);
      expect(entity.price, 200);
      expect(entity.priceAfterDiscount, 150);
      expect(entity.quantity, 10);
      expect(entity.category, "flowers");
      expect(entity.occasion, "valentine");
    });

    test("should handle null fields gracefully", () {
      // Arrange
      final model = BestsellerModel();

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
