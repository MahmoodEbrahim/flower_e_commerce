import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/checkout/domain/entity/checkout_entity.dart';
import 'package:flower_e_commerce/features/checkout/domain/repository/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCheckoutDataUseCase {
  final CheckoutRepository repository;

  GetCheckoutDataUseCase(this.repository);
}