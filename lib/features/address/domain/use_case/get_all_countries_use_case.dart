import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCountriesUseCase{
  final AddressRepositry _addressRepositry;
  GetAllCountriesUseCase(this._addressRepositry);
  Future<LocalDsResult<List<CountryEntity>>> getCountries()async{
    return await _addressRepositry.getCountries();
  }
}