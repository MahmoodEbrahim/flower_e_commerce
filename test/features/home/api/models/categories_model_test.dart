import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';

void main() {
  group('CategoriesModel toEntity', () {
    test('should correctly map CategoriesModel to CategoriesEntity', () {
      // arrange
      final model = CategoriesModel(
        Id: 'cat_1',
        name: 'Roses',
        slug: 'roses-slug',
        image: '',
        createdAt: '2025-08-01',
        updatedAt: '2025-08-15',
        isSuperAdmin: false,
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<CategoriesEntity>());
      expect(entity.id, equals('cat_1'));
      expect(entity.name, equals('Roses'));
      expect(entity.image, equals(''));
    });

    test('should handle null values correctly', () {
      // arrange
      final model = CategoriesModel();

      // act
      final entity = model.toEntity();

      // assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
      expect(entity.image, isNull);
    });
  });
}
