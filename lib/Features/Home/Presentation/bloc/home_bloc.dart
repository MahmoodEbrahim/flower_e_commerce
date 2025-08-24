
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_e_commerce/features/home/presentation/bloc/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/bloc/home_states.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

import '../../domain/usecase/home_usecase.dart';

@injectable
class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeBloc(this.getHomeDataUseCase) : super(HomeInitialState()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoadingState());
      final result = await getHomeDataUseCase.call();
      result.fold(
            (failure) => emit(HomeErrorState(failure.toString())),
            (homeResponse) => emit(HomeSuccessState(homeResponse)),
      );
    });
  }
}