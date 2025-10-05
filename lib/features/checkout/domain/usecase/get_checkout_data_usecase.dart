import 'package:flower_e_commerce/features/checkout/domain/repository/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCheckoutDataUseCase {
  final CheckoutRepository repository;

  GetCheckoutDataUseCase(this.repository);
}