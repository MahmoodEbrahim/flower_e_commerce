import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_home_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_data_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetHomeDataUseCase useCase;
  late MockHomeRepository mockRepository;

  setUpAll(() {
    provideDummy<ApiResult<HomeEntity>>(ApiSucessResult(
      HomeEntity(
          products: [],
          categories: [],
          bestSeller: [],
          occasions: []),
    ));
  });

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetHomeDataUseCase(mockRepository);
  });

  group('GetHomeDataUseCase', () {
    test('should return ApiSuccessResult when repository returns success',
        () async {
      // arrange
      final fakeEntity = HomeEntity(
        products: [],
        categories: [],
        bestSeller: [],
        occasions: [],
      );
      when(mockRepository.getHomeData())
          .thenAnswer((_) async => ApiSucessResult(fakeEntity));

      // act
      final result = await useCase();

      // assert
      expect(result, isA<ApiSucessResult<HomeEntity>>());
      final success = result as ApiSucessResult<HomeEntity>;
      expect(success.data.products, isEmpty);
    });

    test('should return ApiErrorResult when repository returns error',
        () async {
      // arrange
      when(mockRepository.getHomeData())
          .thenAnswer((_) async => ApiErrorResult("Something went wrong"));

      // act
      final result = await useCase();

      // assert
      expect(result, isA<ApiErrorResult<HomeEntity>>());
      final error = result as ApiErrorResult<HomeEntity>;
      expect(error.errorMessage, "Something went wrong");
    });
  });
}
