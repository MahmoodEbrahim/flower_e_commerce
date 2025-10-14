import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';

class TrackingOrderState {
  final bool isLoading;
  String? errorMessage;
  RemoteDataEntity? remoteData;

  TrackingOrderState({this.isLoading = true, this.errorMessage, this.remoteData});

  TrackingOrderState copyWith({
    bool? isLoading,

    String? errorMessage,

    RemoteDataEntity? remoteData,
  }) {
    return TrackingOrderState(
      isLoading: isLoading ?? this.isLoading,

      errorMessage: errorMessage,

      remoteData: remoteData,
    );
  }
}
