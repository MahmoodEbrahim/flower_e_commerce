import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';


void main() {
  group('CartModel.toEntity', () {
    test('should return entity with null cartItems when cartItems is null', () {
      // arrange
      final cartModel = CartModel(
        id: "cart123",
        user: "user123",
        cartItems: null,
        appliedCoupons: [],
        totalPrice: 0,
      );

      // act
      final entity = cartModel.toEntity();

      // assert
      expect(entity.id, "cart123");
      expect(entity.user, "user123");
      expect(entity.cartItems, null);
      expect(entity.appliedCoupons, []);
      expect(entity.totalPrice, 0);
    });

    test('should return entity with correct cartItems when cartItems are provided', () {
      // arrange
      final productModel = ProductModel(
        iid: "prod123",
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
        id: "item123",
        price: 250,
        quantity: 3,
        product: productModel,
      );

      final cartModel = CartModel(
        id: "cart123",
        user: "user123",
        cartItems: [cartItemModel],
        appliedCoupons: [],
        totalPrice: 250,
      );

      // act
      final entity = cartModel.toEntity();

      // assert
      expect(entity.id, "cart123");
      expect(entity.user, "user123");
      expect(entity.cartItems!.length, 1);
      expect(entity.cartItems![0].id, "item123");
      expect(entity.cartItems![0].product!.id, "prod123");
      expect(entity.totalPrice, 250);
    });
  });
}
