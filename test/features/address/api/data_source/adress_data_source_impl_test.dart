import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/api/client/adress_api_services.dart';
import 'package:flower_e_commerce/features/address/api/data_source/adress_data_source_impl.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart' hide Address;
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'adress_data_source_impl_test.mocks.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
@GenerateMocks([AddressesApiServices,AssetBundle])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
late MockAddressesApiServices mockAddressesApiServices;
late AddressRemoteDataSource addressRemoteDataSource;
late MockAssetBundle mockAssetBundle;
setUp((){
  mockAssetBundle=MockAssetBundle();
  mockAddressesApiServices=MockAddressesApiServices();
  addressRemoteDataSource=AddressRemoteDataSourceImpl(
      mockAddressesApiServices,mockAssetBundle);
  mockAssetBundle=MockAssetBundle();
  ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'plugins.flutter.io/path_provider' , ( methodCall) async => null,);
  provideDummy<ApiResult<List<GovernorateEntity>>>(
    ApiSucessResult<List<GovernorateEntity>>([]),
  );
  provideDummy<ApiResult<List<StateEntity>>>(
    ApiSucessResult<List<StateEntity>>([]),
  );
  provideDummy<ApiResult<List<CountryEntity>>>(
    ApiSucessResult<List<CountryEntity>>([]),
  );

});
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
        "zoneName": "Asia\/Kabul",
        "gmtOffset": 16200,
        "gmtOffsetName": "UTC+04:30",
        "abbreviation": "AFT",
        "tzName": "Afghanistan Time"
      }
    ]
  }
    ]
  ''';

group("Address RemoteDataSource test", (){
  const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
AddAdressRequest request=AddAdressRequest(
    street: "Home",
    phone: "01010700700",
    city: "Benha",
    lat:"z",
    long:"z",
    username:"ahmedmuti"
);

  group("Add Address Test", (){
   test("return ApiSuccessResult when api call success", ()async{
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
     when(mockAddressesApiServices.addAddress(any, "Bearer $token")).thenAnswer((_)async
     =>successResponse);
     final result=await addressRemoteDataSource.addAddress(request, token);

     expect(result, isA<ApiSucessResult<List<AddressEntity>>>());

     expect((result as ApiSucessResult).sucessResult,
         successResponse.address?.map((e)=>e.toEntity()).toList());
     verify(mockAddressesApiServices.addAddress(request, "Bearer $token")).called(1);
   });
test("return ApiFailed Result when api call fails on DioException", ()async{
final dioException=DioException(requestOptions: RequestOptions(
  path: "/"
),type: DioExceptionType.connectionTimeout);
when(mockAddressesApiServices.addAddress(request, "Bearer $token")).thenThrow(dioException);
final result=await addressRemoteDataSource.addAddress(request, token);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
verify(mockAddressesApiServices.addAddress(request, "Bearer $token")).called(1);
});
test("return ApiFailed Result when api call fails on Exception", ()async{
  final exception=Exception("Throw Exception");
  when(mockAddressesApiServices.addAddress(any, "Bearer $token")).thenThrow(exception);
  final result =await addressRemoteDataSource.addAddress(request, token);
  expect(result, isA<ApiFailedResult>());
  expect((result as ApiFailedResult).errorMessage, exception.toString());
  verify(mockAddressesApiServices.addAddress(request, "Bearer $token")).called(1);
});
  });
  group("Get All Address Test", (){
    final successResponse=GetAllAddressResponse(
        message: "success",addresses: [
          Addresses(
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
    test("return ApiSuccessResult when call api return success", ()async{
   when(mockAddressesApiServices.getAllAddress("Bearer $token")).thenAnswer
     ((_)async=>successResponse);
   final result=await addressRemoteDataSource.getAllAddress(token);
   expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
   expect((result as ApiSucessResult).sucessResult, successResponse.addresses?.map((e)=>e.toEntity()).toList());
   verify(mockAddressesApiServices.getAllAddress("Bearer $token")).called(1);

    });
    test("return ApiFailedResult when call api return fails on dioException",
            ()async{
      final dioException=DioException(requestOptions: RequestOptions(
        path: ""
      ),type: DioExceptionType.connectionTimeout);
when(mockAddressesApiServices.getAllAddress("Bearer $token")).thenThrow(dioException);
final result=await addressRemoteDataSource.getAllAddress(token);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
verify(mockAddressesApiServices.getAllAddress("Bearer $token")).called(1);
    });
    test("return ApiFailedResult when call api return fails on throwException",
            ()async{
          final exception=Exception("throwException");
          when(mockAddressesApiServices.getAllAddress("Bearer $token")).
          thenThrow(exception);
          final result=await addressRemoteDataSource.getAllAddress(token);
          expect(result, isA<ApiFailedResult>());
          expect((result as ApiFailedResult).errorMessage, exception.toString());
          verify(mockAddressesApiServices.getAllAddress("Bearer $token")).called(1);
        });

  });
  group("Delete Address Test", (){
    const String id="68bea7d4a8bca307f9e2e8ec";
    test("return ApiSuccessResult when api call success", ()async{
      final successResponse=RemoveAddressDto(
        message: "success",
        address: [
Address1(
    street: "Home",
    phone: "01010700700",
    city: "Benha",
    lat:"z",
    long:"z",
    username:"ahmedmuti",
    id: "68beb36ca8bca307f9e2e9fb"
)
        ]
      );
      when(mockAddressesApiServices.deleteAddress("Bearer $token", id)).thenAnswer((_)async=>successResponse);
      final result=await addressRemoteDataSource.removeAddress(token, id);
      expect(result, isA<ApiSucessResult>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockAddressesApiServices.deleteAddress("Bearer $token", id)).called(1);
    });
    test("return ApiFailedResult when api failed on DioException", ()async{
      final dioException=DioException(requestOptions: RequestOptions(
          path: "/"
      ),type: DioExceptionType.connectionTimeout);
      when(mockAddressesApiServices.deleteAddress("Bearer $token", id)).thenThrow(dioException);
final result=await addressRemoteDataSource.removeAddress(token, id);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
verify(mockAddressesApiServices.deleteAddress("Bearer $token", id)).called(1);
    });
test("return ApiFailedResult when api failed On Throw Exception ", ()async{
  final exception=Exception("Throw Exception ");
  when(mockAddressesApiServices.deleteAddress("Bearer $token", id)).thenThrow(exception);
  final result=await addressRemoteDataSource.removeAddress(token, id);
  expect(result, isA<ApiFailedResult>());
  expect((result as ApiFailedResult).errorMessage, exception.toString());
  verify(mockAddressesApiServices.deleteAddress("Bearer $token", id)).called(1);
});
  });
  group("Update Address Test ", (){
    const String id="68bea7d4a8bca307f9e2e8ec";
    test("return ApiSuccessResult when call api success", ()async{
    
      final successResponse=GetAllAddressResponse(
          message: "success",addresses: [
        Addresses(
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
      when(mockAddressesApiServices.updateAddress("Bearer $token", id, any)).thenAnswer((_)async=>successResponse);
final result=await addressRemoteDataSource.updateAddress(token, id, request);
expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
expect((result as ApiSucessResult).sucessResult, successResponse.addresses?.map((e)=>e.toEntity()).toList());
verify(mockAddressesApiServices.updateAddress("Bearer $token", id, request)).called(1);
    });
    test("return ApiFailed Result when api call failed  on Dio Exception", ()async{
final dioException=DioException(requestOptions: RequestOptions(
  path: ""
),type: DioExceptionType.connectionTimeout);
when(mockAddressesApiServices.updateAddress("Bearer $token", id, request)).thenThrow(dioException);
final result=await addressRemoteDataSource.updateAddress(token, id, request);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
verify(mockAddressesApiServices.updateAddress("Bearer $token", id, request)).called(1);
    });
    test("return ApiFailed Result when call api and failed on Throw Exception", ()async{
      final exception=Exception("Throw Exception");
      when(mockAddressesApiServices.updateAddress("Bearer $token", id, request)).thenThrow(exception);
      final result=await addressRemoteDataSource.updateAddress(token, id, request);
      expect(result, isA<ApiFailedResult>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockAddressesApiServices.updateAddress("Bearer $token", id, request)).called(1);
    });
  });
  group("Governorates Data Source", (){
    test("return LocalSuccessResult when call json get governorates and succeess", ()
    async{
when(mockAssetBundle.loadString("assets/json/cities.json",)).thenAnswer((_)
async=>governoratesJson);
final result=await addressRemoteDataSource.getGovernorates();
expect(result , isA<LocalDsSucessResult>());
final data=(result as LocalDsSucessResult).sucessResult;
expect(data.length, 27);
     expect(data.first.nameEn, "Cairo") ;
    });

  });
group("State  Data Source", (){
  test("Should return ApiSuccessResult when load json",()async{
    String governateId="1";
    when(mockAssetBundle.loadString("assets/json/states.json")).thenAnswer((_)async=>statesJson);
    final result=await addressRemoteDataSource.getStates(governateId);
    expect(result, isA<LocalDsSucessResult>());
   final data=(result as LocalDsSucessResult).sucessResult ;
    expect(data[0].cityNameEn, "15 May");
    expect(data[0].cityNameAr, "15 مايو");

  });
});
group("Country DataSource", (){
  test("Should return ApiSuccessResult when load json", ()async{
    when(mockAssetBundle.loadString("assets/json/country.json")).
    thenAnswer((_)async=>countriesJson);
final result=await addressRemoteDataSource.getCountries();
expect(result, isA<LocalDsSucessResult>());
List<CountryEntity> data=((result as LocalDsSucessResult).sucessResult);
final d=data[0];
expect(d.name,"Afghanistan");
    expect(d.phoneCode,"93");
  });
});
});
}
