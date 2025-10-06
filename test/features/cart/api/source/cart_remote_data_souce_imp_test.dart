import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/api/client/cart_api_service.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_item_request_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_item_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/cart_response/cart_response_model.dart';
import 'package:flower_e_commerce/features/cart/api/models/updated_request_body_model.dart';
import 'package:flower_e_commerce/features/cart/api/source/cart_remote_data_souce_imp.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_remote_data_souce_imp_test.mocks.dart';

@GenerateMocks([CartApiService])
void main() {
  late CartRemoteDataSouceImp cartRemoteDataSouceImp;
  late MockCartApiService mockCartApiService;
  late ProductModel fakeProduct;
  late List<CartItemModel> fakeCartItems;
  late CartModel fakeCart;
  late CartResponseDto fakeCartResponse;

  setUpAll(() {
    mockCartApiService = MockCartApiService();
    cartRemoteDataSouceImp = CartRemoteDataSouceImp(mockCartApiService);

    // Fake Product
    fakeProduct = ProductModel(
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

    // Fake Cart Items
    fakeCartItems = [
      CartItemModel(
        id: "68b803e8a8bca307f9e2266a",
        price: 250,
        quantity: 3,
        product: fakeProduct,
      ),
    ];

    // Fake Cart
    fakeCart = CartModel(
      id: "68b6f13fa8bca307f9e21118",
      user: "68b1a4a2a8bca307f9e1c328",
      cartItems: fakeCartItems,
      appliedCoupons: [],
      totalPrice: 1000,
    );

    // Fake Cart Response
    fakeCartResponse = CartResponseDto(
      message: "success",
      numOfCartItems: 1,
      cart: fakeCart,
    );
  });
  group("test addProductToCart function", () {
    test(
      "when call addProductToCart with CartItemRequestEntity as a correct parameter it should return ApiSucessResult  ",
      () async {
        // arrange
        CartItemRequestEntity cartItemRequestEntity = CartItemRequestEntity(
          product: "12345",
          quantity: 3,
        );

        when(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).thenAnswer((_) async => fakeCartResponse);

        // act

        final res = await cartRemoteDataSouceImp.addProductToCart(
          cartItemRequestEntity,
        );

        //assert

        expect(res, isA<SucessResult<CartResponseEntity>>());
        final acResult = res as SucessResult<CartResponseEntity>;
        expect(acResult.sucessResult.numOfCartItems, 1);
        expect(acResult.sucessResult.message, "success");
        expect(acResult.sucessResult.cart!.id, fakeCart.id);
        expect(
          acResult.sucessResult.cart!.cartItems!.length,
          fakeCart.cartItems!.length,
        );
        expect(
          acResult.sucessResult.cart!.cartItems![0].id,
          fakeCart.cartItems![0].id,
        );

        expect(
          acResult.sucessResult.cart!.cartItems![0].product!.id,
          fakeCart.cartItems![0].product!.id,
        );

        verify(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).called(1);
      },
    );

    test(
      "when call addProductToCart with CartItemRequestEntity as a wrong parameter it should return FailedResult with dio exception message  ",
      () async {
        final String dioException = "dio Exception";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioException,
        );
        // arrange
        CartItemRequestEntity cartItemRequestEntity = CartItemRequestEntity(
          product: "12345",
          quantity: 3,
        );

        when(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).thenThrow(mockDioException);

        // act

        final res = await cartRemoteDataSouceImp.addProductToCart(
          cartItemRequestEntity,
        );

        //assert

        expect(res, isA<FailedResult<CartResponseEntity>>());
        final acResult = res as FailedResult<CartResponseEntity>;
        expect(acResult.errorMessage, dioException);
        verify(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).called(1);
      },
    );

    test(
      "when call addProductToCart with CartItemRequestEntity as a wrong parameter it should return FailedResult with exception message  ",
      () async {
        final String exceptionMessage = "Exception";
        final Exception mockException = Exception(exceptionMessage);
        // arrange
        CartItemRequestEntity cartItemRequestEntity = CartItemRequestEntity(
          product: "12345",
          quantity: 3,
        );

        when(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).thenThrow(mockException);

        // act

        final res = await cartRemoteDataSouceImp.addProductToCart(
          cartItemRequestEntity,
        );

        //assert

        expect(res, isA<FailedResult<CartResponseEntity>>());
        final acResult = res as FailedResult<CartResponseEntity>;
        expect(acResult.errorMessage, equals(mockException.toString()));
        verify(
          mockCartApiService.addProductToCart(
            CartItemRequestModel.toModel(cartItemRequestEntity),
          ),
        ).called(1);
      },
    );
  });

  group("test getCartOfUser function", () {
    test(
      "when call getCartOfUser  it should return ApiSucessResult  ",
      () async {
        // arrange

        when(
          mockCartApiService.getCartUser(),
        ).thenAnswer((_) async => fakeCartResponse);

        // act

        final res = await cartRemoteDataSouceImp.getCartOfUser();

        //assert

        expect(res, isA<SucessResult<CartResponseEntity>>());
        final acResult = res as SucessResult<CartResponseEntity>;
        expect(acResult.sucessResult.numOfCartItems, 1);
        expect(acResult.sucessResult.message, "success");
        expect(acResult.sucessResult.cart!.id, fakeCart.id);
        expect(
          acResult.sucessResult.cart!.cartItems!.length,
          fakeCart.cartItems!.length,
        );
        expect(
          acResult.sucessResult.cart!.cartItems![0].id,
          fakeCart.cartItems![0].id,
        );

        expect(
          acResult.sucessResult.cart!.cartItems![0].product!.id,
          fakeCart.cartItems![0].product!.id,
        );

        verify(mockCartApiService.getCartUser()).called(1);
      },
    );

    test(
      "when call getCartOfUser  it should return FailedResult with dio exception message  ",
      () async {
        final String dioException = "dio Exception";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioException,
        );
        // arrange

        when(mockCartApiService.getCartUser()).thenThrow(mockDioException);

        // act

        final res = await cartRemoteDataSouceImp.getCartOfUser();

        //assert

        expect(res, isA<FailedResult<CartResponseEntity>>());
        final acResult = res as FailedResult<CartResponseEntity>;
        expect(acResult.errorMessage, dioException);
      },
    );

    test(
      "when call addProductToCart with CartItemRequestEntity as a wrong parameter it should return FailedResult with exception message  ",
      () async {
        final String exceptionMessage = "Exception";
        final Exception mockException = Exception(exceptionMessage);
        // arrange

        when(mockCartApiService.getCartUser()).thenThrow(mockException);

        // act

        final res = await cartRemoteDataSouceImp.getCartOfUser();

        //assert

        expect(res, isA<FailedResult<CartResponseEntity>>());
        final acResult = res as FailedResult<CartResponseEntity>;
        expect(acResult.errorMessage, equals(mockException.toString()));
      },
    );
  });

  group("test deleteItemFromCart function", () {
    const String itemId = "68b803e8a8bca307f9e2266a";

    test("should return ApiSucessResult when delete is successful", () async {
      // arrange
      when(
        mockCartApiService.deleteItemFromCart(itemId),
      ).thenAnswer((_) async => fakeCartResponse);

      // act
      final res = await cartRemoteDataSouceImp.deleteItemFromCart(itemId);

      // assert
      expect(res, isA<SucessResult<CartResponseEntity>>());
      final acResult = res as SucessResult<CartResponseEntity>;
      expect(acResult.sucessResult.cart!.id, fakeCart.id);
      verify(mockCartApiService.deleteItemFromCart(itemId)).called(1);
    });

    test("should return FailedResult when DioException occurs", () async {
      const String dioExceptionMsg = "dio Exception";
      final DioException dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        message: dioExceptionMsg,
      );

      when(
        mockCartApiService.deleteItemFromCart(itemId),
      ).thenThrow(dioException);

      // act
      final res = await cartRemoteDataSouceImp.deleteItemFromCart(itemId);

      // assert
      expect(res, isA<FailedResult<CartResponseEntity>>());
      final acResult = res as FailedResult<CartResponseEntity>;
      expect(acResult.errorMessage, dioExceptionMsg);
    });

    test("should return FailedResult when Exception occurs", () async {
      const String exceptionMsg = "Exception";
      final Exception exception = Exception(exceptionMsg);

      when(mockCartApiService.deleteItemFromCart(itemId)).thenThrow(exception);

      // act
      final res = await cartRemoteDataSouceImp.deleteItemFromCart(itemId);

      // assert
      expect(res, isA<FailedResult<CartResponseEntity>>());
      final acResult = res as FailedResult<CartResponseEntity>;
      expect(acResult.errorMessage, equals(exception.toString()));
    });
  });

  group("test updateQuantity function", () {
    final UpdatedQuatityRequestEntity updatedReq = UpdatedQuatityRequestEntity(
      itemId: "68b803e8a8bca307f9e2266a",
      updatedRequestBody: UpdatedRequestBodyEntity(quantity: 5),
    );

    test("should return ApiSucessResult when update is successful", () async {
      // arrange
      when(
        mockCartApiService.updateQuantity(
          updatedReq.itemId,
          UpdatedRequestBodyModel.toModel(updatedReq.updatedRequestBody),
        ),
      ).thenAnswer((_) async => fakeCartResponse);

      // act
      final res = await cartRemoteDataSouceImp.updateQuantity(updatedReq);

      // assert
      expect(res, isA<SucessResult<CartResponseEntity>>());
      final acResult = res as SucessResult<CartResponseEntity>;
      expect(acResult.sucessResult.cart!.id, fakeCart.id);
      verify(
        mockCartApiService.updateQuantity(
          updatedReq.itemId,
          UpdatedRequestBodyModel.toModel(updatedReq.updatedRequestBody),
        ),
      ).called(1);
    });

    test("should return FailedResult when DioException occurs", () async {
      const String dioExceptionMsg = "dio Exception";
      final DioException dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        message: dioExceptionMsg,
      );

      when(
        mockCartApiService.updateQuantity(
          updatedReq.itemId,
          UpdatedRequestBodyModel.toModel(updatedReq.updatedRequestBody),
        ),
      ).thenThrow(dioException);

      // act
      final res = await cartRemoteDataSouceImp.updateQuantity(updatedReq);

      // assert
      expect(res, isA<FailedResult<CartResponseEntity>>());
      final acResult = res as FailedResult<CartResponseEntity>;
      expect(acResult.errorMessage, dioExceptionMsg);
    });

    test("should return FailedResult when Exception occurs", () async {
      const String exceptionMsg = "Exception";
      final Exception exception = Exception(exceptionMsg);

      when(
        mockCartApiService.updateQuantity(
          updatedReq.itemId,
          UpdatedRequestBodyModel.toModel(updatedReq.updatedRequestBody),
        ),
      ).thenThrow(exception);

      // act
      final res = await cartRemoteDataSouceImp.updateQuantity(updatedReq);

      // assert
      expect(res, isA<FailedResult<CartResponseEntity>>());
      final acResult = res as FailedResult<CartResponseEntity>;
      expect(acResult.errorMessage, equals(exception.toString()));
    });
  });
}
