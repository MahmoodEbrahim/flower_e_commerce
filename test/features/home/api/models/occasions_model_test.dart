import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';

void main() {
  group("OccasionsModel toEntity", () {
    test("should correctly convert OccasionsModel to OccasionsEntity", () {
      // Arrange
      final model = OccasionsModel(
        iid: "o1",
        name: "Birthday",
        slug: "birthday",
        image: "birthday.png",
        createdAt: "2025-09-16",
        updatedAt: "2025-09-16",
        isSuperAdmin: false,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<OccasionsEntity>());
      expect(entity.id, "o1");
      expect(entity.name, "Birthday");
      expect(entity.image, "birthday.png");
    });

    test("should handle null fields gracefully", () {
      // Arrange
      final model = OccasionsModel();

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.image, isNull);
    });
  });
}
