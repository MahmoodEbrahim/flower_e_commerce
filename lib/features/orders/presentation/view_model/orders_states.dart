import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';

class OrderStates extends Equatable {
  String? errorMessage;
  bool isLoading;
OrdersResponceEntity? OrdersResonse;

  OrderStates({
    this.errorMessage,
    this.isLoading = true,
    this.OrdersResonse,
  });

  OrderStates copyWith({
    String? errorMessage,
    bool? isLoading,
    OrdersResponceEntity? order,
  }) {
    return OrderStates(
        errorMessage: errorMessage ,
        isLoading: isLoading ?? this.isLoading,
        OrdersResonse: order
    );
  }

  @override
  List<Object?> get props => [errorMessage, isLoading, OrdersResonse];
}
