
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/data/repositry/address_repositry_impl.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/time_zone.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repositry_impl_test.mocks.dart';
@GenerateMocks([AddressRemoteDataSource])
void main() {
late MockAddressRemoteDataSource mockAddressRemoteDataSource;
late AddressRepositryImpl addressRepositry;
  setUp((){
mockAddressRemoteDataSource=MockAddressRemoteDataSource();
addressRepositry=AddressRepositryImpl(mockAddressRemoteDataSource);
provideDummy<ApiResult<List<AddressEntity>>>(ApiFailedResult("Dummy Error"));
provideDummy<ApiResult<RemoveAddressDto>>(ApiFailedResult("Dummy Error"));
provideDummy<LocalDsResult<List<CountryEntity>>>(LocalDsFailedResult("Dummy Error"));
provideDummy<LocalDsResult<List<StateEntity>>>(LocalDsFailedResult("Dummy Error"));
provideDummy<LocalDsResult<List<GovernorateEntity>>>(LocalDsFailedResult("Dummy Error"));

  });
  const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
  AddAdressRequest request=AddAdressRequest(
      street: "Home",
      phone: "01010700700",
      city: "Benha",
      lat:"z",
      long:"z",
      username:"ahmedmuti"
  );
const String id="68bea7d4a8bca307f9e2e8ec";
//fake governorates
  final governoratesJson = '''
    [
      {"data": [
        {"id": "1", "governorate_name_ar": "القاهرة", "governorate_name_en": "Cairo"},
        {"id": "2", "governorate_name_ar": "الجيزة", "governorate_name_en": "Giza"}
      ]}
    ]
  ''';
//fake states
  final statesJson = '''
    [
      {"data": [
        {"id": "1", "governorate_id": "1", "city_name_ar": "15 مايو", "city_name_en": "15 May"},
        {"id": "2", "governorate_id": "2", "city_name_ar": "لبساتين", "city_name_en": "Al Basatin"}
      ]}
    ]
  ''';
//fake countries
  final countriesJson = '''
    [
       {
    "isoCode": "AF",
    "name": "Afghanistan",
    "phoneCode": "93",
    "flag": "🇦🇫",
    "currency": "AFN",
    "latitude": "33.00000000",
    "longitude": "65.00000000",
    "timezones": [
      {
        "zoneName": "Asia/Kabul",
        "gmtOffset": 16200,
        "gmtOffsetName": "UTC+04:30",
        "abbreviation": "AFT",
        "tzName": "Afghanistan Time"
      }
    ]
  }
    ]
  ''';
group("Address Repositry", (){
   final successResponse=AddAddressResponse(
       message: "success",address: [

     Address(
         street: "Home",
         phone: "01010700700",
         city: "Benha",
         lat:"z",
         long:"z",
         username:"ahmedmuti",
         Id: "68beb36ca8bca307f9e2e9fb"
     )
   ]
   );
 group("Add Address Repositery", ()
 {
test("return ApiSuccessResult when data source success", ()async{
  final addresses=successResponse.address!.map((e)=>e.toEntity()).toList();
when(mockAddressRemoteDataSource.addAddress(request, token)).thenAnswer((_)
async=>ApiSucessResult(addresses));
final result =await addressRepositry.addAddress(request, token);
expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
expect((result as ApiSucessResult).sucessResult, addresses);
verify(mockAddressRemoteDataSource.addAddress(request, token)).called(1);
});
test("return ApiFailedResult when data source failed", ()async{
  final errorMessage = "Throw Exception";
  when(mockAddressRemoteDataSource.addAddress(any, token)).
  thenAnswer((_)async=>ApiFailedResult(errorMessage));
  final result=await addressRepositry.addAddress(request, token);
  expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage,errorMessage);
verify(mockAddressRemoteDataSource.addAddress(request, token)).called(1);
});
 });

 group("Update Address Repositry", (){

   test("return ApiSuccessResult when datasource success", ()async{
     final addresses=successResponse.address!.map((e)=>e.toEntity()).toList();
when(mockAddressRemoteDataSource.updateAddress(token, id, request)).
thenAnswer((_)async=>ApiSucessResult(addresses));
final result=await addressRepositry.updateAddress(token, id, request);
expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
expect((result as ApiSucessResult).sucessResult, addresses);
verify(mockAddressRemoteDataSource.updateAddress(token, id, request)).called(1);
   });
   test("return ApiFailed Result when datasource failed", ()async{
     final errorMessage="Throw Exception";
     when(mockAddressRemoteDataSource.updateAddress(token, id, request)).
     thenAnswer((_)async=>ApiFailedResult(errorMessage));
     final result=await addressRepositry.updateAddress(token, id, request);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, errorMessage);
verify(mockAddressRemoteDataSource.updateAddress(token, id, request)).called(1);
   });
 });
 group("Remove Address Repositry", (){
   test("return ApiSuccessResult when datasource success", ()async{
     final success=RemoveAddressDto(
         message: "success",
         address: [
           Address1(
               street: "Home",
               phone: "01010700700",
               city: "Cairo",
               lat:"z",
               long:"z",
               username:"ahmedmuti",
               id: "68beb36ca8bca307f9e2e9fb"
           )
         ]
     );

     when(mockAddressRemoteDataSource.removeAddress(token, id)).
     thenAnswer((_)async=>ApiSucessResult(success));
     final result=await addressRepositry.removeAddress(token, id);
     expect(result, isA<ApiSucessResult<RemoveAddressDto>>());
     expect((result as ApiSucessResult).sucessResult, success);
     verify(mockAddressRemoteDataSource.removeAddress(token, id)).called(1);
   });
   test("return ApiFailed Result when datasource failed", ()async{
     final errorMessage="Throw Exception";
     when(mockAddressRemoteDataSource.removeAddress(token, id)).
     thenAnswer((_)async=>ApiFailedResult(errorMessage));
     final result=await addressRepositry.removeAddress(token, id);
     expect(result, isA<ApiFailedResult>());
     expect((result as ApiFailedResult).errorMessage, errorMessage);
     verify(mockAddressRemoteDataSource.removeAddress(token, id)).called(1);
   });
 });
   group("Get Address Repositry", (){
     test("return ApiSuccessResult when datasource success", ()async{

       final addresses=successResponse.address!.map((e)=>e.toEntity()).toList();

       when(mockAddressRemoteDataSource.getAllAddress(token)).
       thenAnswer((_)async=>ApiSucessResult(addresses));
       final result=await addressRepositry.getAllAddress(token);
       expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
       expect((result as ApiSucessResult).sucessResult, addresses);
       verify(mockAddressRemoteDataSource.getAllAddress(token)).called(1);
     });
     test("return ApiFailed Result when datasource failed", ()async{
       final errorMessage="Throw Exception";
       when(mockAddressRemoteDataSource.getAllAddress(token)).
       thenAnswer((_)async=>ApiFailedResult(errorMessage));
       final result=await addressRepositry.getAllAddress(token);
       expect(result, isA<ApiFailedResult>());
       expect((result as ApiFailedResult).errorMessage, errorMessage);
       verify(mockAddressRemoteDataSource.getAllAddress(token)).called(1);
     });
   });
   group("Get Governate ", (){
     test("return list of governorates when data source success", ()async{
       final governorates=[
         GovernorateEntity(id: "1", nameEn: "Cairo", nameAr: "القاهرة"),
         GovernorateEntity(id: "2", nameEn: "Giza", nameAr: "الجيزة"),
         GovernorateEntity(id: "3", nameEn: "Alexandria", nameAr: "الأسكندرية"),
         GovernorateEntity(id: "4", nameEn: "Dakahlia", nameAr: "الدقهلية")

       ];
       when(mockAddressRemoteDataSource.getGovernorates()).thenAnswer((_)
       async=>LocalDsSucessResult(governorates));
       final result =await addressRepositry.getGovernorates();
       expect(result, isA<LocalDsSucessResult>());
       final res=(result as LocalDsSucessResult).sucessResult;
       expect(res.length, 4);
       expect(res[0].nameEn, "Cairo");
       verify(mockAddressRemoteDataSource.getGovernorates()).called(1);
     });
   });
   group("Get Countries", (){
     test("return list of countries when data source success", ()async{
       final countries=[

         CountryEntity(isoCode: "AF", name: "Afghanistan", phoneCode: "93", flag: "🇦🇫", currency: "AFN",
             latitude: "33.00000000", longitude: "65.00000000", timezones: [
               Timezone(
                 zoneName: "Asia/Kabul",
                 gmtOffset: 16200,
                 gmtOffsetName: "UTC+04:30",
                 abbreviation: "AFT",
                 tzName: "Afghanistan Time",
               )
             ])

       ];
       when(mockAddressRemoteDataSource.getCountries()).thenAnswer((_)async=>
       LocalDsSucessResult(countries));
       final result=await addressRepositry.getCountries();
       final res=(result as LocalDsSucessResult).sucessResult;
       expect(res.length, 1);
       expect(res[0].name, "Afghanistan");
       verify(mockAddressRemoteDataSource.getCountries()).called(1);
     });
   });
   group("Get States", (){
     test("return list of states when datasource success", ()async{
       String governateId="1";
       final states=[
         StateEntity(cityId: "1", governorateId: "1", cityNameAr: "15 مايو", cityNameEn: "15 May")
       ];
       when(mockAddressRemoteDataSource.getStates(governateId)).thenAnswer
         ((_)async=>LocalDsSucessResult(states));
       final result=await addressRepositry.getStates(governateId);
       final res=(result as LocalDsSucessResult).sucessResult;
       expect(res.length, 1);
       expect(res[0].cityNameEn, "15 May");
       verify(mockAddressRemoteDataSource.getStates(governateId)).called(1);

     });
   });
 });
}