import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/checkout/domain/entity/order_entity.dart';
import '../../api/models/cash_order_responce_model.dart';
import '../../api/models/online_payment_responce_model.dart';

abstract interface class PaymentRemoteDataSource {
  Future<ApiResult<CashOrderResponce>> createCashOrder(
      Map<String, dynamic> cashorder);
  Future<ApiResult<OnlinePaymentResponce>> createOnlineOrder(
      Map<String, dynamic> onlineorder);

}