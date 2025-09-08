import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AddressRepositry)
class AddressRepositryImpl implements AddressRepositry{
 AddressRemoteDataSource _addressRemoteDataSource;
 AddressRepositryImpl(this._addressRemoteDataSource);
  @override
  Future<ApiResult<List<AddressEntity>>> addAddress(AddAdressRequest
  request, String token) async{
    return await _addressRemoteDataSource.addAddress(request, token);
  }

  @override
  Future<ApiResult<List<AddressEntity>>> getAllAddress(String token) async{
    // TODO: implement getAllAddress
  return await _addressRemoteDataSource.getAllAddress(token);
  }
  @override
  Future<ApiResult<RemoveAddressDto>> removeAddress(String token, String id)async {
    // TODO: implement removeAddress
    return await _addressRemoteDataSource.removeAddress(token, id);
  }
}