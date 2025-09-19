import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../entity/cash_payment_responce_entity.dart';
import '../repository/payment_repository.dart';

@injectable
class CashUseCase{
  PaymentRepository repository;
  @factoryMethod
  CashUseCase(this.repository);

  Future<ApiResult<CashPaymentResponceEntity>> invoke
      (CashOrderRequest cashorder)=>repository.createCashOrder(cashorder);
}