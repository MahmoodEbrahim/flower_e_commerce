part of 'checkout_view_model_bloc.dart';

@immutable
sealed class CheckoutViewModelState {}
class CheckoutViewModelInitial extends CheckoutViewModelState {}
class PaymentOnlineStates extends CheckoutViewModelState with EquatableMixin {
  String? errorMessage;
  bool isLoading;
  String? frame;

  PaymentOnlineStates({
    this.errorMessage,
    this.isLoading = true,
    this.frame,
  });

  PaymentOnlineStates copyWith({
    String? errorMessage,
    bool? isLoading,
    String? order,
  }) {
    return PaymentOnlineStates(
        errorMessage: errorMessage ,
        isLoading: isLoading ?? this.isLoading,
        frame: order
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, frame];
}
class PaymentCashStates extends CheckoutViewModelState with EquatableMixin {
  String? errorMessage;
  bool isLoading;
  CashPaymentResponceEntity? cashPaymentResponceEntity;

  PaymentCashStates({
    this.errorMessage,
    this.isLoading = true,
    this.cashPaymentResponceEntity,
  });

  PaymentCashStates copyWith({
    String? errorMessage,
    bool? isLoading,
    CashPaymentResponceEntity? cashPaymentResponceEntity,
  }) {
    return PaymentCashStates(
        errorMessage: errorMessage ,
        isLoading: isLoading ?? this.isLoading,
        cashPaymentResponceEntity: cashPaymentResponceEntity
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, cashPaymentResponceEntity];
}
