import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/repository/cart_repository.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/delete_item_from_cart.dart';

import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_to_cart_usecase_test.mocks.dart';


@GenerateMocks([CartRepository])
void main() {
  late MockCartRepository mockCartRepository;
  late DeleteItemFromCartUseCase deleteItemFromCartUseCase;
  late CartResponseEntity fakeCartResponse;

  late ProductsEntity fakeProduct;
  late List<CartItemEntity> fakeCartItems;
  late CartEntity fakeCart;

  setUpAll(() {
    mockCartRepository = MockCartRepository();
    deleteItemFromCartUseCase = DeleteItemFromCartUseCase(mockCartRepository);

    fakeProduct = ProductsEntity(
      id: "673e2bd91159920171828139",
      title: "Red Wdding Flower",
      description: "This is a Pack of Red Widding Flowers",
      imgCover:
          "https://flower.elevateegy.com/uploads/5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/ba028e59-410f-43ac-aed5-f4f97c102b98-image_four.png",
        "https://flower.elevateegy.com/uploads/f89bc954-eb0d-4efb-928f-6717f77b69ed-image_one.png",
        "https://flower.elevateegy.com/uploads/5ed2d072-485b-4a53-a0fa-a41412791397-image_three.png",
        "https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png",
      ],
      price: 250,
      priceAfterDiscount: 150,
      quantity: 827,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",
    );

    fakeCartItems = [
      CartItemEntity(
        id: "68b803e8a8bca307f9e2266a",
        price: 250,
        quantity: 3,
        product: fakeProduct,
      ),
    ];

    fakeCart = CartEntity(
      id: "68b6f13fa8bca307f9e21118",
      user: "68b1a4a2a8bca307f9e1c328",
      cartItems: fakeCartItems,
      appliedCoupons: [],
      totalPrice: 1000,
    );

    fakeCartResponse = CartResponseEntity(
      message: "success",
      numOfCartItems: 1,
      cart: fakeCart,
    );
  });

  group("DeleteItemFromCartUseCase Tests", () {
    test(
        "when call deleteItemFromCart with correct itemId it should return ApiSuccessResult",
        () async {
      // arrange
      const itemId = "68b803e8a8bca307f9e2266a";

      final mockResult = ApiSucessResult<CartResponseEntity>(fakeCartResponse);
      provideDummy<ApiResult<CartResponseEntity>>(mockResult);

      when(mockCartRepository.deleteItemFromCart(itemId))
          .thenAnswer((_) async => mockResult);

      // act
      final res = await deleteItemFromCartUseCase.deleteItemFromCart(itemId);

      // assert
      expect(res, isA<ApiSucessResult<CartResponseEntity>>());
      final acResult = res as ApiSucessResult<CartResponseEntity>;
      expect(acResult.sucessResult.cart!.id, fakeCart.id);
      verify(mockCartRepository.deleteItemFromCart(itemId)).called(1);
    });

    test(
        "when call deleteItemFromCart with wrong itemId it should return ApiFailedResult",
        () async {
      // arrange
      const itemId = "wrongId";

      final mockResult = ApiFailedResult<CartResponseEntity>("error");
      provideDummy<ApiResult<CartResponseEntity>>(mockResult);

      when(mockCartRepository.deleteItemFromCart(itemId))
          .thenAnswer((_) async => mockResult);

      // act
      final res = await deleteItemFromCartUseCase.deleteItemFromCart(itemId);

      // assert
      expect(res, isA<ApiFailedResult<CartResponseEntity>>());
      final acResult = res as ApiFailedResult<CartResponseEntity>;
      expect(acResult.errorMessage, "error");
      verify(mockCartRepository.deleteItemFromCart(itemId)).called(1);
    });
  });
}
