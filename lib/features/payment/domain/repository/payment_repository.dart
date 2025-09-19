import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/checkout/domain/entity/order_entity.dart';
import 'package:flower_e_commerce/features/payment/domain/entity/cash_payment_responce_entity.dart';

abstract interface class PaymentRepository {
  Future<ApiResult<CashPaymentResponceEntity>>createCashOrder(Map<String,dynamic>cashorder);
  Future<ApiResult<String>>createOnlineOrder(Map<String,dynamic>onlineorder);
}