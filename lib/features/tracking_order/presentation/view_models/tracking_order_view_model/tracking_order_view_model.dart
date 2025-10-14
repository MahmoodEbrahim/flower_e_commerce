import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/entity/remote_data_entity.dart';
import 'package:flower_e_commerce/features/tracking_order/domain/usecase/get_data_from_remote.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_events.dart';
import 'package:flower_e_commerce/features/tracking_order/presentation/view_models/tracking_order_view_model/tracking_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@singleton
class TrackingOrderViewModel extends Bloc<TrackingOrderEvent, TrackingOrderState> {
  final GetDataFromRemoteUseCase _getDataFromRemoteUseCase;

  TrackingOrderViewModel(this._getDataFromRemoteUseCase) : super(TrackingOrderState()) {

    on<GetDataFromRemoteEvent>(_getDataFromRemote);
     on<CallUserEvent>(_callUser);
     on<WhatsAppUserEvent>(_openWhatsApp);
  }


  Future<void> _getDataFromRemote(
    GetDataFromRemoteEvent event,
    Emitter emit,
  ) async {
    await emit.forEach<Result<RemoteDataEntity?>>(
      _getDataFromRemoteUseCase.getOrderFromRemote(event.orderId),
      onData: (data) {
        switch (data) {
          case SucessResult<RemoteDataEntity?>():
            return state.copyWith(
              remoteData: data.sucessResult,
              isLoading: false,
            );
          case FailedResult<RemoteDataEntity?>():
            return state.copyWith(
              errorMessage: data.errorMessage,
              isLoading: false,
            );
        }
      },
    );
  }

  Future<void> _callUser(CallUserEvent event, Emitter<TrackingOrderState> emit) async {
    final Uri uri = Uri(scheme: Constants.telSchema, path: "0${event.phoneNumber}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      emit(state.copyWith(errorMessage: Constants.callError));
    }
  }

  Future<void> _openWhatsApp(
    WhatsAppUserEvent event,
    Emitter<TrackingOrderState> emit,
  ) async {
    final phone = event.phoneNumber.startsWith("0")
        ? "2${event.phoneNumber.substring(1)}"
        : event.phoneNumber;

    final Uri uri = Uri.parse(
      "https://wa.me/$phone${event.message != null ? "?text=${Uri.encodeComponent(event.message!)}" : ""}",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      emit(state.copyWith(errorMessage: Constants.whatsAppError));
    }
  }



}
