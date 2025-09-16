import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/time_zone.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_countries_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_countries_use_case_test.mocks.dart';

@GenerateMocks([AddressRepositry])
void main() {
  late MockAddressRepositry mockAddressRepositry;
  late GetAllCountriesUseCase getAllCountriesUseCase;
  setUp((){
    mockAddressRepositry=MockAddressRepositry();
    getAllCountriesUseCase=GetAllCountriesUseCase(mockAddressRepositry);
    provideDummy<LocalDsResult<List<CountryEntity>>>(LocalDsFailedResult("Dummy Error"));
  });
  final countries=[

    CountryEntity(isoCode: "AF", name: "Afghanistan", phoneCode: "93", flag: "🇦🇫", currency: "AFN",
        latitude: "33.00000000", longitude: "65.00000000", timezones: [
          Timezone(
            zoneName: "Asia\/Kabul",
            gmtOffset: 16200,
            gmtOffsetName: "UTC+04:30",
            abbreviation: "AFT",
            tzName: "Afghanistan Time",
          )
        ])

  ];
  test('should return list of countries when repo successs', () async{
when(mockAddressRepositry.getCountries()).thenAnswer((_)async=>LocalDsSucessResult(countries));
final result=await getAllCountriesUseCase.getCountries();
final actualResult=(result as LocalDsSucessResult).sucessResult;
expect(actualResult.length, 1);
expect(actualResult[0].name, "Afghanistan");
verify(mockAddressRepositry.getCountries()).called(1);
  });
  test("should throw an Exception when repository throws an exception", ()async{
    final exception=Exception("Failed to Fetch Data");
    when(mockAddressRepositry.getCountries()).thenThrow(exception);
    expect(()=>getAllCountriesUseCase.getCountries(), throwsA(isA<Exception>().
    having((e)=>e.toString(), "message", contains("Failed to Fetch Data"))));
 verify(mockAddressRepositry.getCountries()).called(1);
    verifyNoMoreInteractions(mockAddressRepositry);

  });
}