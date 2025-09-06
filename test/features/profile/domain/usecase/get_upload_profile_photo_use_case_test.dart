import 'dart:io';

import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_upload_profile_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';

import 'get_upload_profile_photo_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;

  setUp((){
    mockProfileRepository = MockProfileRepository();
    GetUploadPhotoProfileUseCase(mockProfileRepository);
    provideDummy<ApiResult<UploadProfilePhotoResponse>>(
        ApiFailedResult<UploadProfilePhotoResponse>("Dummy Error")
    );
  });
group("uploadPhoto", (){
  final photo = File('test_photo.jpg');
  const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";
  final successResponse=UploadProfilePhotoResponse(
      message: "success"
  );
  test("Should return ApiSuccess when profile repositry success", ()async{
when(mockProfileRepository.uploadPhoto(token, photo)).thenAnswer((_)async=>
    ApiSucessResult(successResponse));
final result=await mockProfileRepository.uploadPhoto(token, photo);
expect(result, isA<ApiSucessResult<UploadProfilePhotoResponse>>());
expect((result as ApiSucessResult).sucessResult, successResponse);
verify(mockProfileRepository.uploadPhoto(token, photo)).called(1);
  });
  test("Should return ApiFailedResult when profile repositry failed", ()async{
    final exception = Exception('Upload failed');
    when(mockProfileRepository.uploadPhoto(token, photo)).thenAnswer((_)async=>
        ApiFailedResult(exception.toString()));
    final result=await mockProfileRepository.uploadPhoto(token, photo);
    expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
    expect((result as ApiFailedResult).errorMessage, exception.toString());
    verify(mockProfileRepository.uploadPhoto(token, photo)).called(1);
  });


});
}