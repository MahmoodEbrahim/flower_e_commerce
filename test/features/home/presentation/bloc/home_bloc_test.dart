import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/Features/Home/Presentation/view_model/bloc/home_bloc.dart';
import 'package:flower_e_commerce/Features/Home/Presentation/view_model/bloc/home_events.dart';
import 'package:flower_e_commerce/Features/Home/Presentation/view_model/bloc/home_states.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetHomeDataUseCase extends Mock implements GetHomeDataUseCase {}

void main() {
  late HomeBloc homeBloc;
  late MockGetHomeDataUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetHomeDataUseCase();
    homeBloc = HomeBloc(mockUseCase);
  });

  tearDown(() {
    homeBloc.close();
  });

  group("HomeBloc Test", () {
    final mockHomeModel = Homemodel(
      categories: [],
      products: [],
      bestSeller: [],
      occasions: [],
    );

    blocTest<HomeBloc, HomeStates>(
      "emits [HomeLoadingState, HomeSuccessState] when GetHomeDataEvent succeeds",
      build: () {
        when(mockUseCase()).thenAnswer((_) async => mockHomeModel);
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeSuccessState>(),
      ],
    );

    blocTest<HomeBloc, HomeStates>(
      "emits [HomeLoadingState, HomeErrorState] when GetHomeDataEvent fails",
      build: () {
        when(mockUseCase()).thenThrow(Exception("Failed"));
        return homeBloc;
      },
      act: (bloc) => bloc.add(GetHomeDataEvent()),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>(),
      ],
    );
  });
}
