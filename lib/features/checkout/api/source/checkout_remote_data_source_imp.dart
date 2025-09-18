
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/checkout/api/client/checkout_api_service.dart';
import 'package:flower_e_commerce/features/checkout/data/source/checkout_remote_data_source.dart';
import 'package:flower_e_commerce/features/checkout/domain/entity/order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImp implements CheckoutRemoteDataSource {
  final CheckoutApiService _apiService;
  CheckoutRemoteDataSourceImp(this._apiService);



  }

