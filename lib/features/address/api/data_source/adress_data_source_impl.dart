import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/client/adress_api_services.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
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
     final response=await _apiServices.updateAddress(token, id, request);
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
}