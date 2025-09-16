import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_home_data_usecase.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';


@GenerateMocks([GetHomeDataUseCase])
void main() {
  late MockGetHomeDataUseCase mockUseCase;

  setUpAll(() {
    provideDummy<ApiResult<HomeEntity>>(
      ApiFailedResult<HomeEntity>("dummy"),
    );
  });

  setUp(() {
    mockUseCase = MockGetHomeDataUseCase();
  });

  group("HomeBloc", () {
    final fakeHomeEntity = HomeEntity(
      products: [],
      categories: [],
      occasions: [],
      bestSeller: [],
    );

    blocTest<HomeBloc, HomeStates>(
      "emits [HomeLoadingState, HomeSuccessState] when GetHomeDataEvent succeeds",
      build: () {
        when(mockUseCase.call()).thenAnswer(
              (_) async => ApiSucessResult<HomeEntity>(fakeHomeEntity),
        );
        return HomeBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeSuccessState>().having(
              (state) => state.homeResponse,
          "homeResponse",
          fakeHomeEntity,
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<HomeBloc, HomeStates>(
      "emits [HomeLoadingState, HomeErrorState] when GetHomeDataEvent fails",
      build: () {
        when(mockUseCase.call()).thenAnswer(
              (_) async => ApiFailedResult<HomeEntity>("Network error"),
        );
        return HomeBloc(mockUseCase);
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>().having(
              (state) => state.message,
          "message",
          "Network error",
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );
  });
}
