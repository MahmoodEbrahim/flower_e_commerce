import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_products_detials_by_occasions.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasion_bloc_test.mocks.dart';

@GenerateMocks([GetProductDetialsByOccasionUseCase])
void main() {
  late ProductsDetialsOccasionBloc bloc; // Updated to match the import
  late MockGetProductDetialsByOccasionUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetProductDetialsByOccasionUseCase();
    provideDummy<ApiResult<List<ProductsEntity>>>(
      ApiFailedResult<List<ProductsEntity>>('Dummy error'),
    );
    bloc = ProductsDetialsOccasionBloc(mockUseCase); // Updated bloc name
  });

  tearDown(() {
    bloc.close();
  });

  group('OccasionBloc', () {
    const occasionId = '123';
    final productDetails = ProductsEntity(
      id: '123',
      title: 'Rose Bouquet',
      price: 299,
      images: [
        'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
        'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
        'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
      ],
      imgCover: 'https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png',
      quantity: 1,
      description: 'A beautiful flower of roses',
    );
    final products = [productDetails];
    test('initial state should be OccasionStates with RequestState.loading', () {
      expect(bloc.state.requestState, RequestState.loading);
      expect(bloc.state.productsDetials, isEmpty);
      expect(bloc.state.errorMessage, isNull);
    });
    blocTest<ProductsDetialsOccasionBloc, OccasionStates>(
      'emits [init, success] when use case returns success',
      build: () {
        when(mockUseCase.getProductsDetialsByOccasions(occasionId))
            .thenAnswer((_) async => ApiSucessResult<List<ProductsEntity>>(products));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductsDetialsByOccasionEvent(occassionId: occasionId)),
      expect: () => [
        OccasionStates(requestState: RequestState.init, productsDetials: const [], errorMessage: null),
        OccasionStates(
          requestState: RequestState.success,
          productsDetials: products,
          errorMessage: null,
        ),
      ],
    );
    final errorMessage = 'Failed to load products';
    blocTest<ProductsDetialsOccasionBloc, OccasionStates>(
      'emits [init, error] when use case returns failure',
      build: () {

        when(mockUseCase.getProductsDetialsByOccasions(occasionId))
            .thenAnswer((_) async => ApiFailedResult<List<ProductsEntity>>(errorMessage));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductsDetialsByOccasionEvent(occassionId: occasionId)),
      expect: () => [
        OccasionStates(requestState: RequestState.init, productsDetials: const [], errorMessage: null),
        OccasionStates(
          requestState: RequestState.error,
          productsDetials: const [],
          errorMessage: errorMessage,
        ),
      ],
    );


  });
}
