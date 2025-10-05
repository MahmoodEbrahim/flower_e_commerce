import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddAddressUseCase{
final AddressRepositry _addressRepositry;
GetAddAddressUseCase(this._addressRepositry);
Future<ApiResult<List<AddressEntity>>> addAddress(AddAdressRequest
request, String token) async{
  return await _addressRepositry.addAddress(request, token);
}
}