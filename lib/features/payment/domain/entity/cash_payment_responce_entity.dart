import 'package:equatable/equatable.dart';

import '../../api/models/cash_order_responce_model.dart';




class CashPaymentResponceEntity extends Equatable {

  final String? message;



  const CashPaymentResponceEntity({
    this.message,

  });
  @override
  List<Object?> get props => [
    message,
  ];
}