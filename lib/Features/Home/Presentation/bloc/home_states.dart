
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart'; // تم تصحيح المسار

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final Homemodel homeResponse;

  HomeSuccessState(this.homeResponse);
}

class HomeErrorState extends HomeStates {
  final String message;

  HomeErrorState(this.message);
}