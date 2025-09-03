import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/api/source/profile_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/profile/data/repository/profile_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_imp_test.mocks.dart';
@GenerateMocks([ProfileRemoteDataSourceImp])
void main() {
  late MockProfileRemoteDataSourceImp mockProfileRemoteDataSourceImp;
late  ProfileRepositoryImp profileRepositoryImp;
  setUp((){
    mockProfileRemoteDataSourceImp=MockProfileRemoteDataSourceImp();
    profileRepositoryImp=ProfileRepositoryImp(mockProfileRemoteDataSourceImp);
    provideDummy<ApiResult<ChangePasswordResponse>>(
      ApiFailedResult<ChangePasswordResponse>("Dummy Error")
    );
  });
group("Change Password Repositry Test", (){
  String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY";
  ChangePasswordRequest request=ChangePasswordRequest(
      password: "Mari123@",
      newPassword: "Mari123@1"
  );
  final successResponse=ChangePasswordResponse(
      message: "success",
      token:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY"
  );
  test("should return ApiSuccessResult when remote data source returns success",
          ()async{
    when(mockProfileRemoteDataSourceImp.changePassword(request, token))
        .thenAnswer((_)async=>ApiSucessResult(successResponse));
    final result=await profileRepositoryImp.changePassword(request, token);
expect(result, isA<ApiSucessResult<ChangePasswordResponse>>());
expect((result as ApiSucessResult).sucessResult, successResponse);
verify(mockProfileRemoteDataSourceImp.changePassword(request, token)).called(1);
          });

  test("should return ApiFailedResult when remote data source returns Fails",
          ()async{
    final failureResponse=ChangePasswordResponse(message: "Something went wrong");
        when(mockProfileRemoteDataSourceImp.changePassword(request, token))
            .thenAnswer((_)async=>ApiFailedResult(failureResponse.message!));
        final result=await profileRepositoryImp.changePassword(request, token);
        expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
        expect((result as ApiFailedResult).errorMessage, failureResponse.message);
        verify(mockProfileRemoteDataSourceImp.changePassword(request, token)).called(1);
      });
  test("should return ApiFailedResult on DioException", ()async{
    final dioException=DioException(requestOptions: RequestOptions(
      path: ""
    ),type: DioExceptionType.connectionTimeout);
    when(mockProfileRemoteDataSourceImp.changePassword(request, token)).
  thenAnswer((_)async=>ApiFailedResult(ServerFailure.fromDioError(dioException).errorMessage));
    final result=await profileRepositoryImp.changePassword(request, token);
    expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
    expect((result as ApiFailedResult).errorMessage,"ServerFailure with Api Server");
    verify(mockProfileRemoteDataSourceImp.changePassword(request, token)).called(1);
  });

});
}