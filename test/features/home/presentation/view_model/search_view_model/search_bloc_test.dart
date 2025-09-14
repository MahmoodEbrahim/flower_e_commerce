import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/search_products_usecase.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/search_view_model/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchProductsUseCase])
void main() {
  late SearchBloc searchBloc;
  late MockSearchProductsUseCase mockSearchProductsUseCase;

  setUp(() {
    provideDummy<ApiResult<List<ProductsEntity>>>(
      ApiFailedResult<List<ProductsEntity>>("error"),
    );
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    searchBloc = SearchBloc(mockSearchProductsUseCase);
  });

  final fakeProductEntity = ProductsEntity(
    title: "Dreamy White Roses Bouquet",
    description: "Elevate any celebration with our luxury rose bouquet.",
    imgCover:
        "https://flower.elevateegy.com/uploads/2d8ddf11-935f-4a45-a100-e1e0765a39c3-cover_image.png",
    images: [
      "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
      "https://flower.elevateegy.com/uploads/66fc9304-3ceb-4b73-97dd-730ccf790c49-image_three.png",
      "https://flower.elevateegy.com/uploads/acf9531b-5ca9-4c45-97fc-f81df9d62091-image_two.png",
    ],
    price: 320,
    priceAfterDiscount: 199,
    id: "1",
  );
  group("test search ", () {
    blocTest<SearchBloc, SearchState>(
      "emits [loading, success] when search succeeds",
      build: () {
        when(
          mockSearchProductsUseCase.call("keyword",
            cancelToken: anyNamed("cancelToken"),),
        ).thenAnswer((_) async => ApiSucessResult([fakeProductEntity]));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchProductsEvent("keyword")),
      wait: Duration(milliseconds: 400), //debounce
      expect: () => [
        SearchState(requestState: RequestState.loading, keyword: "keyword"),
        SearchState(
          requestState: RequestState.success,
          products: [fakeProductEntity],
          errorMessage: '',
          keyword: "keyword",
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      "emits [loading, error] when search fails ",
      build: () {
        when(
          mockSearchProductsUseCase.call("keyword",
              cancelToken: anyNamed("cancelToken")),
        ).thenAnswer((_) async => ApiFailedResult("errorMessage"));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchProductsEvent("keyword")),
      wait: Duration(milliseconds: 400),
      expect: () => [
        SearchState(requestState: RequestState.loading, keyword: "keyword"),
        SearchState(
          requestState: RequestState.error,
          errorMessage: 'errorMessage',
          keyword: "keyword",
        ),
      ],
    );

    group("test clear search", () {
      blocTest<SearchBloc, SearchState>(
        'emits [initial] when ClearSearch is added',
        build: () => searchBloc,
        act: (bloc) => bloc.add(ClearSearch()),
        wait: Duration(milliseconds: 300),
        expect: () => [const SearchState()],
      );

      blocTest<SearchBloc, SearchState>(
        '''emits only ClearSearch state when ClearSearch is added during a search,
        cancel request in-flight
            ''',
        build: () {
          when(mockSearchProductsUseCase.call(
            "keyword",
            cancelToken: anyNamed("cancelToken"),
          )).thenAnswer((invocation) async {
            final cancelToken = invocation.namedArguments[#cancelToken] as CancelToken;
            // simulate api calling takes 500ms
            await Future.delayed(const Duration(milliseconds: 500));
            if (cancelToken.isCancelled) {
              throw DioException(
                requestOptions: RequestOptions(path: ''),
                type: DioExceptionType.cancel,
              );
            }
            return ApiSucessResult([fakeProductEntity]);
          });


          return searchBloc;
        },
        act: (bloc) async {
          bloc.add(SearchProductsEvent("keyword"));
          // before the search ends cancel it
          await Future.delayed(const Duration(milliseconds: (200)));
          bloc.add(ClearSearch());
        },
        // after search canceled
        wait: const Duration(milliseconds: 800),
        expect: () => [
          SearchState(requestState: RequestState.loading, keyword: "keyword"),
          const SearchState(),
        ],
      );
    });
  });
}
