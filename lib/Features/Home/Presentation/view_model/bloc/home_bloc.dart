import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/home_usecase.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

import 'home_events.dart';
import 'home_states.dart';

@injectable
class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeBloc(this.getHomeDataUseCase) : super(HomeInitialState()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final Homemodel homeResponse = await getHomeDataUseCase.call();
        emit(HomeSuccessState(homeResponse));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }
}