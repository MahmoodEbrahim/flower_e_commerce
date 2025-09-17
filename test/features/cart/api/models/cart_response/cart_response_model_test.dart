import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_response_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';

void main() {
  group('CartResponseDto.toEntity', () {
    test('should return entity with null cart when cart is null', () {
      // arrange
      final dto = CartResponseDto(
        message: "success",
        numOfCartItems: 0,
        cart: null,
      );

      // act
      final entity = dto.toEntity();

      // assert
      expect(entity.message, "success");
      expect(entity.numOfCartItems, 0);
      expect(entity.cart, null);
    });

    test('should return entity with correct cart when cart is provided', () {
      // arrange
      final productModel = ProductModel(
        iid: "prod123",
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

      final dto = CartResponseDto(
        message: "success",
        numOfCartItems: 1,
        cart: cartModel,
      );

      // act
      final entity = dto.toEntity();

      // assert
      expect(entity.message, "success");
      expect(entity.numOfCartItems, 1);
      expect(entity.cart!.id, "cart123");
      expect(entity.cart!.cartItems!.length, 1);
      expect(entity.cart!.cartItems![0].id, "item123");
      expect(entity.cart!.cartItems![0].product!.id, "prod123");
    });
  });
}
