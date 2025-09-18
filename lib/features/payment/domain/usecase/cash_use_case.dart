import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../entity/cash_payment_responce_entity.dart';
import '../repository/payment_repository.dart';

@injectable
class CashUseCase{
  PaymentRepository repository;
  @factoryMethod
  CashUseCase(this.repository);

  Future<ApiResult<CashPaymentResponceEntity>> invoke(Map<String,dynamic> cashorder)=>repository.createCashOrder(cashorder);
}