import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/data/orders_remote_datasource.dart';
import 'package:flower_e_commerce/features/orders/data/repository/orders_remote_repo_impl.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_entity.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {
  //provideDummyBuilder<ApiResult<OrdersResponceEntity>>(MockResult);
  late OrdersRepoImpl ordersRepoImpl;
  late MockOrdersRemoteDataSource mockOrdersRemoteDataSource;

  late OrdersEntity fakeOrder;
  late List<OrdersEntity> fakeOrders;
  late OrdersResponceEntity fakeOrdersResponse;

  setUpAll(() {
    mockOrdersRemoteDataSource = MockOrdersRemoteDataSource();
    ordersRepoImpl =
        OrdersRepoImpl(ordersRemoteDataSource: mockOrdersRemoteDataSource);
  }
  );
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
        isDelivered: false,


      );
  fakeOrders = [fakeOrder];
  fakeOrdersResponse = OrdersResponceEntity(
    message: "success",
    orders: fakeOrders,
  );
  group("test getOrders in OrdersRepoImpl", () {
    test('GetOrders returns ApiSuccessResult', () async {
      final MockResult = ApiSucessResult<OrdersResponceEntity>(
          fakeOrdersResponse);
      // Arrange
      provideDummy<ApiResult<OrdersResponceEntity>>(MockResult);
      when(mockOrdersRemoteDataSource.GetOrders())
          .thenAnswer((_) async => ApiSucessResult((fakeOrdersResponse)));

      // Act
      final result = await ordersRepoImpl.GetOrders();

      // Assert
      expect(result, isA<ApiSucessResult<OrdersResponceEntity>>());
      final data = (result as ApiSucessResult<OrdersResponceEntity>)
          .sucessResult;
      expect(data, isA<OrdersResponceEntity>());
      expect(data.orders, isA<List<OrdersEntity>>());
      expect(data.orders?.length, 1);
      expect(data.orders?.first.Id, "673e2bd91159920171828139");
      verify(mockOrdersRemoteDataSource.GetOrders()).called(1);
      verifyNoMoreInteractions(mockOrdersRemoteDataSource);
    });
    test("returns ApiFailedResult", () async {
      final mockResult = ApiFailedResult<OrdersResponceEntity>("error");
      provideDummy<ApiResult<OrdersResponceEntity>>(mockResult);

      when(mockOrdersRemoteDataSource.GetOrders())
          .thenAnswer((_) async => mockResult);

      final res = await await ordersRepoImpl.GetOrders();
      ;

      expect(res, isA<ApiFailedResult<OrdersResponceEntity>>());
      final acResult = res as ApiFailedResult<OrdersResponceEntity>;
      expect(acResult.errorMessage, "error");
      verify(mockOrdersRemoteDataSource.GetOrders()).called(1);
    });
  });
}
