import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpdateAddressUseCase{
  AddressRepositry _addressRepositry;
  GetUpdateAddressUseCase(this._addressRepositry);
  Future<ApiResult<List<AddressEntity>>> updateAddress(String token, String id,
      AddAdressRequest request )async {
    return await _addressRepositry.updateAddress(token, id, request);
  }
}