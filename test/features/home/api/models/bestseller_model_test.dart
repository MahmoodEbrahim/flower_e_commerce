import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';

void main() {
  group('BestsellerModel toEntity', () {
    test('should correctly map BestsellerModel to BestSellerEntity', () {
      // arrange
      final model = BestsellerModel(
        id: 'b1',
        title: 'Red Roses',
        description: 'Fresh red roses',
        imgCover: '',
        images: ['img1.jpg', 'img2.jpg'],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 10,
        category: 'Flowers',
        occasion: 'Valentine',
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<BestSellerEntity>());
      expect(entity.id, 'b1');
      expect(entity.title, 'Red Roses');
      expect(entity.description, 'Fresh red roses');
      expect(entity.price, 200);
      expect(entity.priceAfterDiscount, 150);
      expect(entity.quantity, 10);
      expect(entity.category, 'Flowers');
      expect(entity.occasion, 'Valentine');
    });

    test('should handle null values correctly', () {
      // arrange
      final model = BestsellerModel();

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
