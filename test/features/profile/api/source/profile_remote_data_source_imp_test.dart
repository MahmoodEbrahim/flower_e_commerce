import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/api/source/profile_remote_data_source_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_imp_test.mocks.dart';
@GenerateMocks([ProfileApiService])
void main() {
 late ProfileRemoteDataSourceImp profileRemoteDataSourceImp;
 late MockProfileApiService mockProfileApiService;
late File photo;
 const String token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";

 setUp((){
mockProfileApiService=MockProfileApiService();
profileRemoteDataSourceImp=ProfileRemoteDataSourceImp(mockProfileApiService);
photo=File("/mock/path/to/file.jpg");
 });
  group("Upload Profile Photo RemoteDataSource", (){

   final successResponse=UploadProfilePhotoResponse(
    message: "success"
   );
   test("Should return ApiSuccessResult when api success", ()async{
when(mockProfileApiService.uploadPhoto("Bearer $token", photo)).thenAnswer((_)async=>successResponse);
final result=await profileRemoteDataSourceImp.uploadPhoto(token, photo);
expect(result, isA<ApiSucessResult<UploadProfilePhotoResponse>>());
expect((result as ApiSucessResult).sucessResult, successResponse);
verify(mockProfileApiService.uploadPhoto("Bearer $token", photo)).called(1);
   });
   test("Should return ApiFailedResult on Dio Exception Error", ()async{
    final dioException=DioException(requestOptions: RequestOptions(
     path: ''
    ),type: DioExceptionType.connectionTimeout);
    when(mockProfileApiService.uploadPhoto("Bearer $token", photo)).thenThrow(dioException);
    final result=await profileRemoteDataSourceImp.uploadPhoto(token, photo);
    expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
    expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
    verify(mockProfileApiService.uploadPhoto("Bearer $token", photo)).called(1);
   });
test("Should return ApiFailedResult when Throw Exception ", ()async{
 final exception=Exception("Throw Exception");
 when(mockProfileApiService.uploadPhoto("Bearer $token", photo)).
 thenThrow(exception);
 final result=await profileRemoteDataSourceImp.uploadPhoto(token, photo);
 expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
 expect((result as ApiFailedResult).errorMessage, exception.toString());
 verify(mockProfileApiService.uploadPhoto("Bearer $token", photo)).called(1);
});


 });
  group("Edit Profile RemoteDataSource", (){

   EditProfileRequest request=EditProfileRequest(
       firstName: "mariam",
       lastName: "Mohmed",
       email: "mariammohmed.25720@gmail.com",
       phone: "+201061728082"
   );
   final successResponse=EditProfileResponsea(
       message: "success",user: User(
       Id: "68a21825a8bca307f9de9365",
       firstName: "mariam",
       lastName: "Mohmed",
       email: "mariammohmed.25720@gmail.com",
       password: "T8lSnOaFaPjq6q",
       gender: "female",
       phone: "+201061728082",
       photo: "https://flower.elevateegy.com/uploads/b6bfe840-15b4-49aa-aba2-1b14b314744f-1756969431858.jpg",
       role: "user",
       wishlist: [],
       addresses: [],
       createdAt: "2025-08-17T17:57:57.084Z",
       passwordChangedAt: "2025-08-31T11:56:33.668Z"
   )
   );
   test("Should return ApiSuccessResult when api success", ()async{
    when(mockProfileApiService.editProfile("Bearer $token", any)).thenAnswer((_)async=>successResponse);
    final result=await profileRemoteDataSourceImp.editProfile(token, request);
    expect(result, isA<ApiSucessResult<EditProfileResponsea>>());
    expect((result as ApiSucessResult).sucessResult, successResponse);
    verify(mockProfileApiService.editProfile("Bearer $token", request)).called(1);
   });

   test("Should return ApiFailedResult on DioException", ()async{
    final dioException=DioException(requestOptions: RequestOptions(
        path: ''
    ),type: DioExceptionType.connectionTimeout);
    when(mockProfileApiService.editProfile("Bearer $token", request)).thenThrow(dioException);
    final result=await profileRemoteDataSourceImp.editProfile(token, request);
    expect(result, isA<ApiFailedResult<EditProfileResponsea>>());
    expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
    verify(mockProfileApiService.editProfile("Bearer $token", request)).called(1);
   });
   test("Should return ApiFailedResult on throw Exception", ()async{
    final exception=Exception("Throw Exception");
    when(mockProfileApiService.editProfile("Bearer $token", request)).thenThrow(exception);
    final result=await profileRemoteDataSourceImp.editProfile(token, request);
    expect(result, isA<ApiFailedResult<EditProfileResponsea>>());
    expect((result as ApiFailedResult).errorMessage,exception.toString());
    verify(mockProfileApiService.editProfile("Bearer $token", request)).called(1);
   });


  });
}