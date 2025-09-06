import 'package:flower_e_commerce/features/checkout/domain/repository/checkout_repository.dart';
import 'package:injectable/injectable.dart';
import '../source/checkout_remote_data_source.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImp implements CheckoutRepository {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;
  CheckoutRepositoryImp(this._checkoutRemoteDataSource);

}