

import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_map_event.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_map_view_model/tracking_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../domain/entity/remote_data_entity.dart';
import '../../../domain/usecase/get_data_from_remote.dart';
@injectable
class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final GetDataFromRemoteUseCase _getDataFromRemoteUseCase;

  TrackingBloc(this._getDataFromRemoteUseCase) : super(TrackingInitial()) {
    on<ListenToOrderStreamEvent>(_onListenToOrderStream);
  }

  Future<void> _onListenToOrderStream(
      ListenToOrderStreamEvent event, Emitter<TrackingState> emit) async {
    emit(TrackingLoading());
    final stream = _getDataFromRemoteUseCase.getOrderFromRemote(event.orderId);

    await emit.forEach<Result<RemoteDataEntity>>(stream,
        onData: (result) {
          if (result is SucessResult<RemoteDataEntity>) {
            return TrackingLoaded(result.sucessResult);
          } else if (result is FailedResult) {
            return TrackingError("error tracking the order");
          } else {
            return TrackingLoading();
          }
        });
  }
}
