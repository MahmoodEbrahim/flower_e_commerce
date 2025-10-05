import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllGovernorateUseCase{
  final AddressRepositry _addressRepositry;
  GetAllGovernorateUseCase(this._addressRepositry);
  Future<LocalDsResult<List<GovernorateEntity>>> getGovernorates()async{
    return await _addressRepositry.getGovernorates();
  }
}