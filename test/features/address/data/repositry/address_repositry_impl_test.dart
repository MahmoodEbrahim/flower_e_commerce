import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/data/data_source/adress_data_source.dart';
import 'package:flower_e_commerce/features/address/data/repositry/address_repositry_impl.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
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
 });
}