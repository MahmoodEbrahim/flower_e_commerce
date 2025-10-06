import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:injectable/injectable.dart';

import '../../data/source/payment_remote_data_source.dart';
import '../client/payment_api_service.dart';
import '../models/cash_order_responce_model.dart';
import '../models/online_payment_responce_model.dart';

@Injectable(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImp implements PaymentRemoteDataSource {
  final PaymentApiService _apiService;
  @factoryMethod
  PaymentRemoteDataSourceImp(this._apiService);

  @override
  Future<Result<CashOrderResponce>> createCashOrder(
    CashOrderRequest cashorder,
  ) async {
    try {
      final result = await _apiService.createCashOrder(cashorder);

      return SucessResult(result);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }

  @override
  Future<Result<OnlinePaymentResponce>> createOnlineOrder(
    CashOrderRequest onlineorder,
  ) async {
    try {
      final result = await _apiService.createOnlineOrder(onlineorder);

      return SucessResult(result);
    } catch (e) {
      return FailedResult(e.toString());
    }
  }
}
