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
    provideDummy<Result<HomeEntity>>(FailedResult<HomeEntity>("dummy"));
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

        final mockResult = SucessResult<HomeEntity>(fakeHomeEntity);

        when(mockRepository.getHomeData()).thenAnswer((_) async => mockResult);

        final result = await useCase();

        expect(result, isA<SucessResult<HomeEntity>>());
        final success = result as SucessResult<HomeEntity>;
        expect(success.sucessResult, equals(fakeHomeEntity));
        verify(mockRepository.getHomeData()).called(1);
      },
    );

    test(
      "should return FailedResult when repository returns failure",
      () async {
        final mockError = FailedResult<HomeEntity>("Network error");

        when(mockRepository.getHomeData()).thenAnswer((_) async => mockError);

        final result = await useCase();

        expect(result, isA<FailedResult<HomeEntity>>());
        final failure = result as FailedResult<HomeEntity>;
        expect(failure.errorMessage, equals("Network error"));
        verify(mockRepository.getHomeData()).called(1);
      },
    );
  });
}
