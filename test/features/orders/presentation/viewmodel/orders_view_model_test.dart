import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:flower_e_commerce/features/orders/domain/usecase/get_orders_usecase.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/Orders_View_model.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_events.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_view_model_test.mocks.dart';

@GenerateMocks([GetOrdersUseCase])
void main(){
  late MockGetOrdersUseCase mockGetOrdersUseCase;
  late GetOrdersUseCase getOrdersUseCase;
  late OrdersViewModel ordersViewModel;
  late OrdersEntity fakeOrder;
  late List<OrdersEntity> fakeOrders;
  late OrdersResponceEntity fakeOrdersResponse;
  setUpAll((){
    mockGetOrdersUseCase=MockGetOrdersUseCase();
    getOrdersUseCase=mockGetOrdersUseCase;
    ordersViewModel=OrdersViewModel(getOrdersUseCase);

  });
  fakeOrder =
      OrdersEntity(
        Id: "673e2bd91159920171828139",
        totalPrice: 250,
        state: "pending",
        createdAt: "2023-10-01T10:00:00Z",
        orderItems: [],
        user: "user123",
        paymentType: "Credit Card",
        isPaid: true,
        isDelivered: false,);
  fakeOrders = [fakeOrder];
  fakeOrdersResponse = OrdersResponceEntity(
    message: "success",
    orders: fakeOrders,
  );
  group("test getorders function",(){
    blocTest<OrdersViewModel,OrderStates>(
      'emits loading then success and calls usecase',
      build:(){
        ordersViewModel=OrdersViewModel(getOrdersUseCase);
        final mockresult=ApiSucessResult<OrdersResponceEntity>(fakeOrdersResponse);
        provideDummy<ApiResult<OrdersResponceEntity>>(mockresult);
        when(mockGetOrdersUseCase.GetOrders()).thenAnswer((_) async=>mockresult);

        return ordersViewModel;},
      act:(bloc)=>bloc.add(GetOrderEvent()),
      expect: ()=>[
        OrderStates(isLoading: true, errorMessage: null,OrdersResonse: null),
        OrderStates(isLoading: false, errorMessage: null, OrdersResonse: fakeOrdersResponse),
      ],
      verify: (_){
        verify(mockGetOrdersUseCase.GetOrders()).called(1);
      },

    );
    blocTest<OrdersViewModel,OrderStates>(
      'emits loading then failure with old data and calls usecase',
      build:(){
        ordersViewModel=OrdersViewModel(getOrdersUseCase);
        final mockresult=ApiFailedResult<OrdersResponceEntity>("error");
        provideDummy<ApiResult<OrdersResponceEntity>>(mockresult);
        when(mockGetOrdersUseCase.GetOrders()).thenAnswer((_) async=>mockresult);

        return ordersViewModel;},
      act:(bloc)=>bloc.add(GetOrderEvent()),
      expect: ()=>[
        OrderStates(isLoading: true, errorMessage: null,OrdersResonse: null),
        OrderStates(isLoading: false, errorMessage:"error", OrdersResonse: ordersViewModel.state.OrdersResonse),
      ],
      verify: (_){
        verify(mockGetOrdersUseCase.GetOrders()).called(1);
      },

    );
  });
  

}
/*group("test getCartOfUser function", () {
    blocTest<CartViewModel, CartStates>(
      'emits loading then success and calls usecase',
      build: () {

          cartViewModel = CartViewModel(
        mockAddToCartUsecase,
        mockGetCartOfUserUseCase,
        mockDeleteItemFromCartUseCase,
        mockUpdateQuatityUseCase);

        final mockResult = ApiSucessResult<CartResponseEntity>(fakeCartResponse);
        provideDummy<ApiResult<CartResponseEntity>>(mockResult);

        when(mockGetCartOfUserUseCase.getCartOfUser()).thenAnswer((_) async => mockResult);
        return cartViewModel;
      },
      act: (bloc) => bloc.add(GetCartItemsEvent()),
      expect: () => [
        CartStates(isLoading: true, errorMessage: null, cartResonse: null),
        CartStates(isLoading: false, errorMessage: null, cartResonse: fakeCartResponse),
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
        mockUpdateQuatityUseCase);

        final mockResult = ApiFailedResult<CartResponseEntity>("error");
        provideDummy<ApiResult<CartResponseEntity>>(mockResult);

        when(mockGetCartOfUserUseCase.getCartOfUser())
            .thenAnswer((_) async => mockResult);
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
*/