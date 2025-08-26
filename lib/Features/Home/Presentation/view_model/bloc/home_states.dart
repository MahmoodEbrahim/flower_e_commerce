import 'package:flower_e_commerce/features/home/data/models/home_model.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final HomeEntity homeResponse;

  HomeSuccessState(this.homeResponse);
}

class HomeErrorState extends HomeStates {
  final String message;

  HomeErrorState(this.message);
}