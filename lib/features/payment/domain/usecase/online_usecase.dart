import 'package:flower_e_commerce/features/payment/domain/repository/payment_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';

@injectable
class OnlineUsecase{
  PaymentRepository repository;
  @factoryMethod
  OnlineUsecase(this.repository);

  Future<ApiResult<String>> invoke(Map<String,dynamic> onlineorder)=>repository.createOnlineOrder(onlineorder);
}