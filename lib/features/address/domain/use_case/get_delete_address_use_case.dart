import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDeleteAddressUseCase{
  final AddressRepositry _addressRepositry;
  GetDeleteAddressUseCase(this._addressRepositry);
  Future<ApiResult<RemoveAddressDto>> removeAddress(String token, String id) async {
    return await _addressRepositry.removeAddress(token, id);
  }
}