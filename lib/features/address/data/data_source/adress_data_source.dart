
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';

abstract interface class AddressRemoteDataSource{
Future<ApiResult<List<AddressEntity>>>
addAddress(AddAdressRequest request,String token);
Future<ApiResult <List<AddressEntity>>>getAllAddress(String token);

Future<ApiResult<RemoveAddressDto>> removeAddress(String token, String id);

}