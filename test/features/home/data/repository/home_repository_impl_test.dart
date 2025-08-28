import 'package:flower_e_commerce/features/home/data/repository/home_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group('HomeRepositoryImpl.getHomeData', () {
    test('should return ApiSuccessResult when remote data source succeeds', () async {
      // arrange
      final fakeEntity = HomeEntity(
        products: [],
        categories: [],
        bestSeller: [],
        occasions: [],
      );
      when(mockRemoteDataSource.getHomeData())
          .thenAnswer((_) async => ApiSucessResult(fakeEntity));

      // act
      final result = await repository.getHomeData();

      // assert
      expect(result, isA<ApiSucessResult<HomeEntity>>());
      final successResult = result as ApiSucessResult<HomeEntity>;
      expect(successResult.data.products, isEmpty);
      expect(successResult.data.categories, isEmpty);
      expect(successResult.data.bestSeller, isEmpty);
      expect(successResult.data.occasions, isEmpty);
    });

    test('should return ApiErrorResult when remote data source throws', () async {
      // arrange
      when(mockRemoteDataSource.getHomeData()).thenThrow(Exception("Remote error"));

      // act
      final result = await repository.getHomeData();

      // assert
      expect(result, isA<ApiErrorResult<HomeEntity>>());
      final errorResult = result as ApiErrorResult<HomeEntity>;
      expect(errorResult.errorMessage, contains("Exception: Remote error"));
    });
  });
}
