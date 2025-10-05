import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllAddressesUseCase{
  final AddressRepositry _addressRepositry;
  GetAllAddressesUseCase(this._addressRepositry);
  Future<ApiResult<List<AddressEntity>>> getAllAddress(String token) async{
    return await _addressRepositry.getAllAddress(token);
  }
}