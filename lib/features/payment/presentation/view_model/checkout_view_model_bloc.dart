import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:flower_e_commerce/features/payment/domain/entity/cash_payment_responce_entity.dart';
import 'package:flower_e_commerce/features/payment/domain/usecase/cash_use_case.dart';
import 'package:flower_e_commerce/features/payment/domain/usecase/online_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'checkout_view_model_event.dart';
part 'checkout_view_model_state.dart';

@injectable
class CheckoutViewModelBloc
    extends Bloc<CheckoutViewModelEvent, CheckoutViewModelState> {
  @factoryMethod
  CheckoutViewModelBloc(this.cashUseCase, this.onlineUseCase)
    : super(CheckoutViewModelInitial()) {
    on<PayCashOrderEvent>(payCashOrder);
    on<PayOnlineOrderEvent>(payOnlineOrder);
  }

  CashUseCase cashUseCase;
  OnlineUsecase onlineUseCase;

  payCashOrder(PayCashOrderEvent event, Emitter emit) async {
    emit(PaymentCashStates(isLoading: true));
    var result = await cashUseCase.invoke(event.cashorder);
    switch (result) {
      case SucessResult<CashPaymentResponceEntity>():
        {
          emit(
            PaymentCashStates(
              isLoading: false,
              cashPaymentResponceEntity: result.sucessResult,
            ),
          );
        }
      case FailedResult<CashPaymentResponceEntity>():
        {
          emit(
            PaymentCashStates(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          );
        }
    }
  }

  payOnlineOrder(PayOnlineOrderEvent event, Emitter emit) async {
    emit(PaymentOnlineStates(isLoading: true));
    var result = await onlineUseCase.invoke(event.onlineorder);
    switch (result) {
      case SucessResult<String>():
        {
          emit(
            PaymentOnlineStates(isLoading: false, frame: result.sucessResult),
          );
        }
      case FailedResult<String>():
        {
          emit(
            PaymentOnlineStates(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          );
        }
    }
  }
}
