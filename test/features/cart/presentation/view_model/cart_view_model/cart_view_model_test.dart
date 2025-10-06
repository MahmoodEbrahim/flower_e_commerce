import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_item_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_quatity_request_entity.dart';
import 'package:flower_e_commerce/features/cart/domain/entity/updated_request_body.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/delete_item_from_cart.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/get_cart_of_user.dart';
import 'package:flower_e_commerce/features/cart/domain/usecase/update_quatity.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_events.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_states.dart';
import 'package:flower_e_commerce/features/cart/presentation/view_model/cart_view_model/cart_view_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'cart_view_model_test.mocks.dart';

@GenerateMocks([
  AddToCartUsecase,
  DeleteItemFromCartUseCase,
  GetCartOfUserUseCase,
  UpdateQuatityUseCase,
])
void main() {
  late MockAddToCartUsecase mockAddToCartUsecase;
  late MockDeleteItemFromCartUseCase mockDeleteItemFromCartUseCase;
  late MockGetCartOfUserUseCase mockGetCartOfUserUseCase;
  late MockUpdateQuatityUseCase mockUpdateQuatityUseCase;

  late ProductsEntity fakeProduct;
  late List<CartItemEntity> fakeCartItems;
  late CartEntity fakeCart;
  late UpdatedQuatityRequestEntity updatedReq;
  late CartResponseEntity fakeCartResponse;
  late CartViewModel cartViewModel;

  setUpAll(() {
    mockUpdateQuatityUseCase = MockUpdateQuatityUseCase();
    mockDeleteItemFromCartUseCase = MockDeleteItemFromCartUseCase();
    mockGetCartOfUserUseCase = MockGetCartOfUserUseCase();
    mockAddToCartUsecase = MockAddToCartUsecase();
    cartViewModel = CartViewModel(
      mockAddToCartUsecase,
      mockGetCartOfUserUseCase,
      mockDeleteItemFromCartUseCase,
      mockUpdateQuatityUseCase,
    );

    fakeProduct = ProductsEntity(
      id: "673e2bd91159920171828139",
      title: "Red Wedding Flower",
      description: "This is a Pack of Red Wedding Flowers",
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
    updatedReq = UpdatedQuatityRequestEntity(
      itemId: "68b803e8a8bca307f9e2266a",
      updatedRequestBody: UpdatedRequestBodyEntity(quantity: 2),
    );
  });

  group("test add to cart function", () {
    final cartItemRequestEntity = CartItemRequestEntity(
      product: "p123",
      quantity: 2,
    );

    blocTest<CartViewModel, CartStates>(
      'emit 2 states one with sucess data that return from apiSuccess Result and second with loading and both with null error message',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = SucessResult<CartResponseEntity>(fakeCartResponse);
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockAddToCartUsecase.addProductToCart(cartItemRequestEntity),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(
        AddToCartEvent(cartItemRequestEntity: cartItemRequestEntity),
      ),
      expect: () {
        return [
          CartStates(isLoading: true, errorMessage: null, cartResonse: null),
          CartStates(
            isLoading: false,
            errorMessage: null,
            cartResonse: fakeCartResponse,
          ),
        ];
      },
    );

    blocTest<CartViewModel, CartStates>(
      'emit 2 states one with old data and error message that return from FailedResult and second with loading ',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = FailedResult<CartResponseEntity>("error");
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockAddToCartUsecase.addProductToCart(cartItemRequestEntity),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(
        AddToCartEvent(cartItemRequestEntity: cartItemRequestEntity),
      ),
      expect: () {
        return [
          CartStates(isLoading: true, errorMessage: null, cartResonse: null),
          CartStates(isLoading: false, errorMessage: "error"),
        ];
      },
    );
  });

  group("test getCartOfUser function", () {
    blocTest<CartViewModel, CartStates>(
      'emits loading then success and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = SucessResult<CartResponseEntity>(fakeCartResponse);
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockGetCartOfUserUseCase.getCartOfUser(),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(GetCartItemsEvent()),
      expect: () => [
        CartStates(isLoading: true, errorMessage: null, cartResonse: null),
        CartStates(
          isLoading: false,
          errorMessage: null,
          cartResonse: fakeCartResponse,
        ),
      ],
      verify: (_) {
        verify(mockGetCartOfUserUseCase.getCartOfUser()).called(1);
      },
    );

    blocTest<CartViewModel, CartStates>(
      'emits loading then failure with old data and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = FailedResult<CartResponseEntity>("error");
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockGetCartOfUserUseCase.getCartOfUser(),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(GetCartItemsEvent()),
      expect: () => [
        CartStates(isLoading: true, errorMessage: null, cartResonse: null),
        CartStates(
          isLoading: false,
          errorMessage: "error",
          cartResonse: cartViewModel.state.cartResonse,
        ),
      ],
      verify: (_) {
        verify(mockGetCartOfUserUseCase.getCartOfUser()).called(1);
      },
    );
  });

  group("test deleteItemFromCart function", () {
    blocTest<CartViewModel, CartStates>(
      'emits loading then success and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = SucessResult<CartResponseEntity>(fakeCartResponse);
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockDeleteItemFromCartUseCase.deleteItemFromCart("item1"),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(DeleteItemFromCartEvent(itemId: "item1")),
      expect: () => [
        CartStates(
          isLoading: false,
          errorMessage: null,
          cartResonse: fakeCartResponse,
        ),
      ],
      verify: (_) {
        verify(
          mockDeleteItemFromCartUseCase.deleteItemFromCart("item1"),
        ).called(1);
      },
    );

    blocTest<CartViewModel, CartStates>(
      'emits loading then failure with old data and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = FailedResult<CartResponseEntity>("error");
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockDeleteItemFromCartUseCase.deleteItemFromCart("item1"),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(DeleteItemFromCartEvent(itemId: "item1")),
      expect: () => [CartStates(isLoading: false, errorMessage: "error")],
      verify: (_) {
        verify(
          mockDeleteItemFromCartUseCase.deleteItemFromCart("item1"),
        ).called(1);
      },
    );
  });

  group("test updateQuatity function", () {
    blocTest<CartViewModel, CartStates>(
      'emits loading then success and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = SucessResult<CartResponseEntity>(fakeCartResponse);
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockUpdateQuatityUseCase.updateQuantity(updatedReq),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(UpdateQuatityItemCEvent(updatedReq: updatedReq)),
      expect: () => [
        CartStates(
          isLoading: false,
          errorMessage: null,
          cartResonse: fakeCartResponse,
        ),
      ],
      verify: (_) {
        verify(mockUpdateQuatityUseCase.updateQuantity(updatedReq)).called(1);
      },
    );

    blocTest<CartViewModel, CartStates>(
      'emits loading then failure with old data and calls usecase',
      build: () {
        cartViewModel = CartViewModel(
          mockAddToCartUsecase,
          mockGetCartOfUserUseCase,
          mockDeleteItemFromCartUseCase,
          mockUpdateQuatityUseCase,
        );

        final mockResult = FailedResult<CartResponseEntity>("error");
        provideDummy<Result<CartResponseEntity>>(mockResult);

        when(
          mockUpdateQuatityUseCase.updateQuantity(updatedReq),
        ).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(UpdateQuatityItemCEvent(updatedReq: updatedReq)),
      expect: () => [CartStates(isLoading: false, errorMessage: "error")],
      verify: (_) {
        verify(mockUpdateQuatityUseCase.updateQuantity(updatedReq)).called(1);
      },
    );
  });
}
