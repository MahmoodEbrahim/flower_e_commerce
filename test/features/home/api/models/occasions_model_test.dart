import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasions_entity.dart';

void main() {
  group('OccasionsModel toEntity', () {
    test('should correctly map OccasionsModel to OccasionsEntity', () {
      // arrange
      final model = OccasionsModel(
        Id: 'occ_1',
        name: 'Birthday',
        slug: 'birthday-slug',
        image: '',
        createdAt: '2025-08-01',
        updatedAt: '2025-08-20',
        isSuperAdmin: false,
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<OccasionsEntity>());
      expect(entity.id, equals('occ_1'));
      expect(entity.name, equals('Birthday'));
    });

    test('should handle null values correctly', () {
      // arrange
      final model = OccasionsModel();

      // act
      final entity = model.toEntity();

      // assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.image, isNull);
    });
  });
}
