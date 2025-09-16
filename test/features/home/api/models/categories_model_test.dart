import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';

void main() {
  group("CategoriesModel toEntity", () {
    test("should correctly convert CategoriesModel to CategoriesEntity", () {
      // Arrange
      final model = CategoriesModel(
        iid: "c1",
        name: "Flowers",
        slug: "flowers",
        image: "flowers.png",
        createdAt: "2025-09-16",
        updatedAt: "2025-09-16",
        isSuperAdmin: false,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<CategoriesEntity>());
      expect(entity.id, "c1");
      expect(entity.name, "Flowers");
      expect(entity.image, "flowers.png");
    });

    test("should handle null fields gracefully", () {
      // Arrange
      final model = CategoriesModel();

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.image, isNull);
    });
  });
}
