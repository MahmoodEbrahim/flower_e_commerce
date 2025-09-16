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

  setUp(() {
    provideDummy<ApiResult<HomeEntity>>(ApiFailedResult<HomeEntity>("dummy"));
    mockRepository = MockHomeRepository();
    useCase = GetHomeDataUseCase(mockRepository);
  });

  group("GetHomeDataUseCase", () {
    test(
      "should return ApiSuccessResult when repository returns success",
      () async {
        final fakeHomeEntity = HomeEntity(
          categories: [],
          occasions: [],
          products: [],
        );

        final mockResult = ApiSucessResult<HomeEntity>(fakeHomeEntity);

        when(mockRepository.getHomeData()).thenAnswer((_) async => mockResult);

        final result = await useCase();

        expect(result, isA<ApiSucessResult<HomeEntity>>());
        final success = result as ApiSucessResult<HomeEntity>;
        expect(success.sucessResult, equals(fakeHomeEntity));
        verify(mockRepository.getHomeData()).called(1);
      },
    );

    test(
      "should return ApiFailedResult when repository returns failure",
      () async {
        final mockError = ApiFailedResult<HomeEntity>("Network error");

        when(mockRepository.getHomeData()).thenAnswer((_) async => mockError);

        final result = await useCase();

        expect(result, isA<ApiFailedResult<HomeEntity>>());
        final failure = result as ApiFailedResult<HomeEntity>;
        expect(failure.errorMessage, equals("Network error"));
        verify(mockRepository.getHomeData()).called(1);
      },
    );
  });
}
