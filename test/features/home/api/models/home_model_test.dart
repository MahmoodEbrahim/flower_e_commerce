import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/home_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/api/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/api/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/api/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

void main() {
  group('HomeModel toEntity', () {
    test('should correctly map HomeModel to HomeEntity', () {
      // arrange
      final model = HomeModel(
        message: 'success',
        products: [
          ProductModel(
            id: 'p1',
            title: 'Red Roses',
            description: 'Beautiful red roses',
            imgCover: '',
            price: 100,
            priceAfterDiscount: 80,
            quantity: 10,
            category: 'Flowers',
            occasion: 'Valentine',
          ),
        ],
        categories: [
          CategoriesModel(
            Id: 'c1',
            name: 'Roses',
            slug: 'roses',
            image: '',
          ),
        ],
        bestSeller: [
          BestsellerModel(
            id: 'b1',
            title: 'White Tulips',
            description: 'Fresh white tulips',
            imgCover: '',
            price: 150,
            priceAfterDiscount: 120,
            quantity: 5,
            category: 'Flowers',
            occasion: 'Wedding',
          ),
        ],
        occasions: [
          OccasionsModel(
            Id: 'o1',
            name: 'Birthday',
            slug: 'birthday',
            image: '',
          ),
        ],
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<HomeEntity>());
      expect(entity.products!.length, 1);
      expect(entity.products!.first.id, 'p1');
      expect(entity.categories!.first.id, 'c1');
      expect(entity.bestSeller!.first.id, 'b1');
      expect(entity.occasions!.first.id, 'o1');
    });

    test('should handle null lists correctly', () {
      // arrange
      final model = HomeModel();

      // act
      final entity = model.toEntity();

      // assert
      expect(entity.products, isNull);
      expect(entity.categories, isNull);
      expect(entity.bestSeller, isNull);
      expect(entity.occasions, isNull);
    });
  });
}
