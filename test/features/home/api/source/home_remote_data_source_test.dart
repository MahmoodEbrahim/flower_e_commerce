import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/api/models/home_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([HomeApiService])
void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockHomeApiService mockApiService;

  setUp(() {
    mockApiService = MockHomeApiService();
    dataSource = HomeRemoteDataSourceImpl(mockApiService);
  });

  group('HomeRemoteDataSourceImpl.getHomeData', () {
    test('should return ApiSuccessResult when API call is successful', () async {
      // arrange
      final homeModel = HomeModel(
        message: "success",
        products: [],
        categories: [],
        bestSeller: [],
        occasions: [],
      );
      when(mockApiService.getHomeData()).thenAnswer((_) async => homeModel);

      // act
      final result = await dataSource.getHomeData();

      // assert
      expect(result, isA<ApiSucessResult<HomeEntity>>());
      final successResult = result as ApiSucessResult<HomeEntity>;
      expect(successResult.data.products, isEmpty);
      expect(successResult.data.categories, isEmpty);
      expect(successResult.data.bestSeller, isEmpty);
      expect(successResult.data.occasions, isEmpty);
    });

    test('should return ApiErrorResult when API throws exception', () async {
      // arrange
      when(mockApiService.getHomeData()).thenThrow(Exception("API error"));

      // act
      final result = await dataSource.getHomeData();

      // assert
      expect(result, isA<ApiErrorResult<HomeEntity>>());
      final errorResult = result as ApiErrorResult<HomeEntity>;
      expect(errorResult.errorMessage, contains("API error"));
    });
  });
}
