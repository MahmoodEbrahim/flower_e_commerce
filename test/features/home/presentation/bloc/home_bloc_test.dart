import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/features/home/Presentation/view_model/home_view_model/home_bloc.dart';
import 'package:flower_e_commerce/features/home/Presentation/view_model/home_view_model/home_events.dart';
import 'package:flower_e_commerce/features/home/Presentation/view_model/home_view_model/home_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_home_data_usecase.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([GetHomeDataUseCase])
void main() {
  late MockGetHomeDataUseCase mockGetHomeDataUseCase;

  setUp(() {
    mockGetHomeDataUseCase = MockGetHomeDataUseCase();
    provideDummy<ApiResult<HomeEntity>>(ApiSucessResult(
      HomeEntity(
          products: [],
          categories: [],
          bestSeller: [],
          occasions: []),
    ));
  });

  group('HomeBloc', () {
    final fakeEntity = HomeEntity(
      products: [],
      categories: [],
      bestSeller: [],
      occasions: [],
    );

    test('initial state should be HomeInitialState', () {
      final bloc = HomeBloc(mockGetHomeDataUseCase);
      expect(bloc.state, isA<HomeInitialState>());
    });

    blocTest<HomeBloc, HomeStates>(
      'emits [HomeLoadingState, HomeSuccessState] when usecase returns success',
      build: () {
        when(mockGetHomeDataUseCase.call())
            .thenAnswer((_) async => ApiSucessResult(fakeEntity));
        return HomeBloc(mockGetHomeDataUseCase);
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeSuccessState>().having((s) => s.homeResponse, 'homeResponse', fakeEntity),
      ],
    );

    blocTest<HomeBloc, HomeStates>(
      'emits [HomeLoadingState, HomeErrorState] when usecase returns error',
      build: () {
        when(mockGetHomeDataUseCase.call())
            .thenAnswer((_) async => ApiErrorResult('error message'));
        return HomeBloc(mockGetHomeDataUseCase);
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>().having((s) => s.message, 'message', 'error message'),
      ],
    );
  });
}
