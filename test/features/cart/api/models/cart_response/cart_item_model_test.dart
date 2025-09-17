import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';

void main() {
  group('CartItemModel.toEntity', () {
    test('should return entity with null product when product is null', () {
      // arrange
      final cartItemModel = CartItemModel(
        product: null,
        price: 250,
        quantity: 3,
        id: "item123",
      );

      // act
      final entity = cartItemModel.toEntity();

      // assert
      expect(entity.product, null);
      expect(entity.price, 250);
      expect(entity.quantity, 3);
      expect(entity.id, "item123");
    });

    test('should return entity with correct product when product is provided', () {
      // arrange
      final productModel = ProductModel(
        id: "prod123",
        title: "Red Flower",
        description: "A red flower",
        imgCover: "https://example.com/img.png",
        images: ["https://example.com/img1.png"],
        price: 250,
        priceAfterDiscount: 200,
        quantity: 10,
        category: "cat123",
        occasion: "occ123",
      );

      final cartItemModel = CartItemModel(
        product: productModel,
        price: 250,
        quantity: 3,
        id: "item123",
      );

      // act
      final entity = cartItemModel.toEntity();

      // assert
      expect(entity.product!.id, "prod123");
      expect(entity.product!.title, "Red Flower");
      expect(entity.price, 250);
      expect(entity.quantity, 3);
      expect(entity.id, "item123");
    });
  });
}
