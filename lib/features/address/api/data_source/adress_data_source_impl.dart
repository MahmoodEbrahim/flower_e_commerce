import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/client/adress_api_services.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/time_zone.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:AddressRemoteDataSource )
class AddressRemoteDataSourceImpl implements AddressRemoteDataSource{
 AddressesApiServices _apiServices;
 AddressRemoteDataSourceImpl(this._apiServices);
  @override
  Future<ApiResult<List<AddressEntity>>> addAddress(AddAdressRequest request, String token) async{
   try{
     final response=await _apiServices.addAddress(request, "Bearer $token");
     final address=response.address?.map((e)=>e.toEntity()).toList()??[];
     return ApiSucessResult(address!);
   }catch(error){
    if(error is DioException){
return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
    } else{
return ApiFailedResult(error.toString());
    }
   }
  }
  @override
  Future<ApiResult <List<AddressEntity>>> getAllAddress(String token)async {
try{
  final response=await _apiServices.getAllAddress("Bearer $token");
  final addresses=response.addresses?.map((e)=>e.toEntity()).toList();
  return ApiSucessResult(addresses!);
}catch(error){
  if(error is DioException){
    return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
  }else{
    return ApiFailedResult(error.toString());
  }
}

  }
@override
  Future<ApiResult<RemoveAddressDto>> removeAddress(String token, String id) async{
  try{
    final response=await _apiServices.deleteAddress("Bearer $token", id);
    return ApiSucessResult(response);
  }catch(error){
    if(error is DioException){
      return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
    }else{
      return ApiFailedResult(error.toString());
    }
  }
  }
  @override
  Future<ApiResult<List<AddressEntity>>> updateAddress
      (String token, String id, AddAdressRequest request) async{
   try{
     final response=await _apiServices.updateAddress("Bearer $token", id, request);
     final addresses=response.addresses?.map((e)=>e.toEntity()).toList()??[];
     return ApiSucessResult(addresses);
   }catch(error){
     if(error is DioException){
       return ApiFailedResult(ServerFailure.fromDioError(error).errorMessage);
     }
     else {
       return ApiFailedResult(error.toString());
     }
   }
  }
  @override
  Future<List<GovernorateEntity>> getGovernorates() async{

     final response=await rootBundle.loadString("assets/json/cities.json");
     final data=json.decode(response)as List<dynamic>;
     final governatesData=data[2]['data'] as List<dynamic>;
     final governates=governatesData.map((json)=>
         GovernorateEntity(id: json["id"],
         nameAr: json["governorate_name_ar"], nameEn: json["governorate_name_en"],)).toList();
     return governates;

  }
  @override
  Future<List<StateEntity>> getStates(String governateId)async {

      final response=await rootBundle.loadString("assets/json/states.json");
      final data=jsonDecode(response)as List<dynamic>;
final statesData=data[2]["data"]as List<dynamic>;
final states=statesData.map((json){

  return StateEntity(cityId: json["id"],
      governorateId:json["governorate_id"],
      cityNameAr: json["city_name_ar"],
      cityNameEn: json["city_name_en"],);
}).toList();
final statesByCities=states.where((e)=>e.governorateId==governateId).toList();
return statesByCities;

  }
  @override
  Future<List<CountryEntity>> getCountries()async {

      final response=await rootBundle.loadString("assets/json/country.json");
      final data=jsonDecode(response)as List<dynamic>;

      final countries=data.map((json){
final timezonesJson=json["timezones"] as List<dynamic>;
final times=timezonesJson.map((e)=>Timezone(zoneName: e["zoneName"],
    gmtOffset: e["gmtOffset"],
    gmtOffsetName:e["gmtOffsetName"],
    abbreviation: e["abbreviation"],
    tzName: e["tzName"], )).toList();
return CountryEntity(isoCode: json["isoCode"], name: json["name"],
    phoneCode: json["phoneCode"], flag: json["flag"], currency: json["currency"],
    latitude: json["latitude"], longitude: json["longitude"], timezones: times);

      }).toList();
    return countries;

  }
}
