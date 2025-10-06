import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';

abstract interface class AddressRemoteDataSource {
  Future<Result<List<AddressEntity>>> addAddress(
    AddAdressRequest request,
    String token,
  );
  Future<Result<List<AddressEntity>>> getAllAddress(String token);

  Future<Result<RemoveAddressDto>> removeAddress(String token, String id);
  Future<Result<List<AddressEntity>>> updateAddress(
    String token,
    String id,
    AddAdressRequest request,
  );
  Future<LocalDsResult<List<GovernorateEntity>>> getGovernorates();
  Future<LocalDsResult<List<StateEntity>>> getStates(String governateId);
  Future<LocalDsResult<List<CountryEntity>>> getCountries();
}
