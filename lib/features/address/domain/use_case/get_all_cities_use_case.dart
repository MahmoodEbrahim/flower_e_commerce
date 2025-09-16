import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class  GetAllStatesUseCase{
  AddressRepositry _addressRepositry;
  GetAllStatesUseCase(this._addressRepositry);
  Future<LocalDsResult<List<StateEntity>>> getStates(String governateId)async{
    return await _addressRepositry.getStates(governateId);
  }
}
