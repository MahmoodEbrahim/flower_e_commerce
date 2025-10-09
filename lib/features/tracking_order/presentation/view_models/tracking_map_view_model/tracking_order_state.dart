import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final RemoteDataEntity remoteData;
  
  TrackingLoaded(this.remoteData);
}

class TrackingError extends TrackingState {
  final String message;

  TrackingError(this.message);
}
