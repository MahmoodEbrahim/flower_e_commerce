import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCountriesUseCase{
  AddressRepositry _addressRepositry;
  GetAllCountriesUseCase(this._addressRepositry);
  Future<List<CountryEntity>> getCountries()async{
    return await _addressRepositry.getCountries();
  }
}