import 'package:flower_e_commerce/features/checkout/domain/repository/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersByCheckoutUrlUseCase {
  final CheckoutRepository _checkoutRepository;
  GetOrdersByCheckoutUrlUseCase(this._checkoutRepository);

}