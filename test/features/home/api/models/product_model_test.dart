import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';

void main() {
  group('ProductModel toEntity', () {
    test('should correctly map ProductModel to ProductsEntity', () {
      // arrange
      final model = ProductModel(
        id: 'prod_1',
        title: 'Luxury Flower Box',
        description: 'A premium box of luxury flowers',
        imgCover: '',
        images: ['img1.jpg', 'img2.jpg'],
        price: 250,
        priceAfterDiscount: 200,
        quantity: 5,
        category: 'Flowers',
        occasion: 'Anniversary',
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<ProductsEntity>());
      expect(entity.id, equals('prod_1'));
      expect(entity.title, equals('Luxury Flower Box'));
      expect(entity.description, equals('A premium box of luxury flowers'));
      expect(entity.price, equals(250));
      expect(entity.priceAfterDiscount, equals(200));
      expect(entity.quantity, equals(5));
      expect(entity.category, equals('Flowers'));
      expect(entity.occasion, equals('Anniversary'));
    });

    test('should handle null values correctly', () {
      // arrange
      final model = ProductModel();

      // act
      final entity = model.toEntity();

      // assert
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
