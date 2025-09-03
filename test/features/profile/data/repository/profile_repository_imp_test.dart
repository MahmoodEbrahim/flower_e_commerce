import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/data/repository/profile_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/profile/data/source/profile_remote_data_source.dart';

import 'profile_repository_imp_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
late ProfileRepositoryImp profileRepositoryImp;
late MockProfileRemoteDataSource mockProfileRemoteDataSource;
late File photo;
setUp((){
  mockProfileRemoteDataSource=MockProfileRemoteDataSource();
  profileRepositoryImp=ProfileRepositoryImp(mockProfileRemoteDataSource);
  photo=File("/mock/path/to/file.jpg");
  provideDummy<ApiResult<UploadProfilePhotoResponse>>(
      ApiFailedResult<UploadProfilePhotoResponse>("Dummy Error")
  );
});
  group("Upload Photo", (){
    const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";
final successResponse=UploadProfilePhotoResponse(
  message: "success"
);
    test('should return ApiResultsuccess when data source succeeds', () async {
      when(mockProfileRemoteDataSource.uploadPhoto(token, photo))
          .thenAnswer((_) async => ApiSucessResult(successResponse));
      final result = await profileRepositoryImp.uploadPhoto(token, photo);
      expect(result, isA<ApiSucessResult<UploadProfilePhotoResponse>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRemoteDataSource.uploadPhoto(token, photo)).called(1);
    });
    test("should return ApiFailedResult when data source failed", ()async{
      final exception = Exception('Upload failed');
      when(mockProfileRemoteDataSource.uploadPhoto(token, photo)).thenAnswer((_)async=>

          ApiFailedResult(exception.toString()));
      final result=await profileRepositoryImp.uploadPhoto(token, photo);
    expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
    expect((result as ApiFailedResult).errorMessage, exception.toString());
    verify(mockProfileRemoteDataSource.uploadPhoto(token, photo)).called(1);
    });

});
}