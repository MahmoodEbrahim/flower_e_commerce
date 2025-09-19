import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/checkout/domain/entity/order_entity.dart';
import 'package:flower_e_commerce/features/checkout/domain/repository/checkout_repository.dart';
import 'package:flower_e_commerce/features/payment/api/models/cash_order_responce_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/online_payment_responce_model.dart';
import 'package:flower_e_commerce/features/payment/api/models/request/cash_order_request.dart';
import 'package:flower_e_commerce/features/payment/domain/entity/cash_payment_responce_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/payment_repository.dart';
import '../source/payment_remote_data_source.dart';

/*@Injectable(asRepository)
class PaymentRepositoryImp implements CheckoutRepository {
  final PaymentRemoteDataSource _checkoutRemoteDataSource;
  PaymentRepositoryImp(this._checkoutRemoteDataSource);

}*/
@Injectable(as: PaymentRepository)
class  PaymentRepositoryImpl implements PaymentRepository{
  final PaymentRemoteDataSource _paymentRemoteDataSource;
  @factoryMethod
  PaymentRepositoryImpl(this._paymentRemoteDataSource);

  @override
  Future<ApiResult<CashPaymentResponceEntity>>
  createCashOrder(CashOrderRequest cashorder)async {
   var result=await _paymentRemoteDataSource.createCashOrder(cashorder);
   switch(result){

     case ApiSucessResult<CashOrderResponce>():{
       return ApiSucessResult(result.sucessResult.toentity());

     }

     case ApiFailedResult<CashOrderResponce>():
        {
          return ApiFailedResult(result.errorMessage);
        }
   }
  }

  @override
  Future<ApiResult<String>> createOnlineOrder(Map<String, dynamic> onlineorder) async{
    var result=await _paymentRemoteDataSource.createOnlineOrder(onlineorder);
    switch(result){

      case ApiSucessResult<OnlinePaymentResponce>():{
        return ApiSucessResult(result.sucessResult.session?.url??" ");

      }

      case ApiFailedResult<OnlinePaymentResponce>():
        {
          return ApiFailedResult(result.errorMessage);
        }
    }

  }

}