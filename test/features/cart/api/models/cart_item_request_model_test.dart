import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_item_request_model.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';

void main() {
  group('test toModel function in CartItemRequestModel  ', () {
    test('when call toModel function with null values it should return CartItemRequestEntity with null values', () {
      // arrange
      final CartItemRequestEntity nullEntity = CartItemRequestEntity();

      // act
      final model = CartItemRequestModel.toModel(nullEntity);

      // assert
      expect(model.product, null);
      expect(model.quantity, null);
    });

    test('when call toModel function with fake values it should return CartItemRequestEntity with same fake values', () {
      // arrange
      final CartItemRequestEntity fakeEntity = CartItemRequestEntity(
        product: "12345",
        quantity: 3,
      );

      // act
      final model = CartItemRequestModel.toModel(fakeEntity);

      // assert
      expect(model.product, "12345");
      expect(model.quantity, 3);
    });
  });
}
