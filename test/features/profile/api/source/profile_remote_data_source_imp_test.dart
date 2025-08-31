import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/api/source/profile_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_imp_test.mocks.dart';
@GenerateMocks([ProfileApiService])
void main() {
late MockProfileApiService mockProfileApiService;
late ProfileRemoteDataSourceImp profileRemoteDataSourceImp;
setUp((){
 mockProfileApiService=MockProfileApiService();
 profileRemoteDataSourceImp=ProfileRemoteDataSourceImp(mockProfileApiService);
});

 group("Change Password Test", (){
  String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY";
  Map<String,dynamic>request={
   "password": "Mari123@",
   "newPassword": "Mari123@1"
  };
  ChangePasswordRequest request1=ChangePasswordRequest(password:
  "Mari123@", newPassword:  "Mari123@1");

  final successResponse=ChangePasswordResponse(
   message: "success",
      token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY"
  );
test("return ApiSuccessResult when api return success", ()async{
 when(mockProfileApiService.changePassword(request, "Bearer $token")).thenAnswer((_)
 async=>successResponse);
 final result=await profileRemoteDataSourceImp.changePassword(request1, token);
 expect(result, isA<ApiSucessResult>());
 expect((result as ApiSucessResult).sucessResult,
    successResponse);
verify(mockProfileApiService.changePassword(request, "Bearer $token")).called(1);
});
test("return ApiFailedResult  when api  fails", ()async{
 final failureResponse=ChangePasswordResponse(message: "Something went wrong");
 when(mockProfileApiService.changePassword(request, "Bearer $token")).thenAnswer((_)async=>failureResponse);
 final result=await profileRemoteDataSourceImp.changePassword(request1, token);
 expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
 expect((result as ApiFailedResult).errorMessage, failureResponse.message);
 verify(mockProfileApiService.changePassword(request, "Bearer $token")).called(1);
});
test("should return ApiFailedResult on DioException", ()async{
 final  dioException=DioException(requestOptions: RequestOptions(
  path: "",
 ),type: DioExceptionType.connectionTimeout);
 when(mockProfileApiService.changePassword(request, "Bearer $token")).thenThrow(dioException);
 final result=await profileRemoteDataSourceImp.changePassword(request1, token);
 expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
 expect((result as ApiFailedResult).errorMessage, "ServerFailure with Api Server");
 verify(mockProfileApiService.changePassword(request, "Bearer $token")).called(1);
});
test("should return ApiFailed Result when throw exception", ()async{
 final exception=Exception("Throw Exception");
 when(mockProfileApiService.changePassword(request, "Bearer $token")).thenThrow(exception);
 final result=await profileRemoteDataSourceImp.changePassword(request1, token);
 expect(result , isA<ApiFailedResult<ChangePasswordResponse>>());
 expect((result as ApiFailedResult).errorMessage, exception.toString());
});
 });
}