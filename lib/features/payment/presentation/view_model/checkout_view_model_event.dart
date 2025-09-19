part of 'checkout_view_model_bloc.dart';

@immutable
sealed class CheckoutViewModelEvent {}
final class PayCashOrderEvent extends CheckoutViewModelEvent{
  CashOrderRequest cashorder;
  PayCashOrderEvent(this.cashorder);
}
final class PayOnlineOrderEvent extends CheckoutViewModelEvent{
  Map<String,dynamic> onlineorder;
  PayOnlineOrderEvent(this.onlineorder);
}

