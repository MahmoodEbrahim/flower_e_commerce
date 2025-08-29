import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_home_data_usecase.dart';
import 'home_events.dart';
import 'home_states.dart';

@injectable
class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeBloc(this.getHomeDataUseCase) : super(HomeInitialState()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoadingState());
      final result = await getHomeDataUseCase.call();

      switch (result) {
        case ApiSucessResult<HomeEntity>():
          emit(HomeSuccessState(result.sucessResult));
        case ApiFailedResult<HomeEntity>():
          emit(HomeErrorState(result.errorMessage));
      }
    });
  }
}