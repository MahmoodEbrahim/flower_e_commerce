
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';

abstract interface class AddressRemoteDataSource{
Future<ApiResult<List<AddressEntity>>>
addAddress(AddAdressRequest request,String token);
Future<ApiResult <List<AddressEntity>>>getAllAddress(String token);

Future<ApiResult<RemoveAddressDto>> removeAddress(String token, String id);
Future<ApiResult <List<AddressEntity>>>updateAddress(String token,String id,AddAdressRequest request);
Future<ApiResult<List<GovernorateEntity>>> getGovernorates();
Future<ApiResult<List<StateEntity>>> getStates(String governateId);

}