import 'package:equatable/equatable.dart';





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