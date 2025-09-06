import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
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
  setUp(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepositoryImp = ProfileRepositoryImp(mockProfileRemoteDataSource);
    photo = File("/mock/path/to/file.jpg");
    provideDummy<ApiResult<UploadProfilePhotoResponse>>(
        ApiFailedResult<UploadProfilePhotoResponse>("Dummy Error")
    );
    provideDummy<ApiResult<EditProfileResponsea>>(
        ApiFailedResult<EditProfileResponsea>("Dummy Error")
    );
    provideDummy<ApiResult<ChangePasswordResponse>>(
        ApiFailedResult<ChangePasswordResponse>("Dummy Error")
    );
  });
  const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY3NDU4OTV9.l-rqns6hgcyes9JCw4fRD6u2Z0LiAbEHYSovpsFjb7E";

  group("Upload Photo Repositry", () {
    final successResponse = UploadProfilePhotoResponse(
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
    test("should return ApiFailedResult when data source failed", () async {
      final exception = Exception('Upload failed');
      when(mockProfileRemoteDataSource.uploadPhoto(token, photo)).thenAnswer((
          _) async =>

          ApiFailedResult(exception.toString()));
      final result = await profileRepositoryImp.uploadPhoto(token, photo);
      expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockProfileRemoteDataSource.uploadPhoto(token, photo)).called(1);
    });
  });
  group("Edit Profile Repositry", () {
    EditProfileRequest request = EditProfileRequest(
        firstName: "mariam",
        lastName: "Mohmed",
        email: "mariammohmed.25720@gmail.com",
        phone: "+201061728082"
    );
    final successResponse = EditProfileResponsea(
        message: "success", user: User(
        id: "68a21825a8bca307f9de9365",
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
    test("should return ApiResultsuccess when data source success ", () async {
      when(mockProfileRemoteDataSource.editProfile(token, request)).thenAnswer((
          _) async
      => ApiSucessResult<EditProfileResponsea>(successResponse));
      final result = await profileRepositoryImp.editProfile(token, request);
      expect(result, isA<ApiSucessResult<EditProfileResponsea>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRemoteDataSource.editProfile(token, request)).called(1);
    });
    test("should return ApiFailedsuccess when data source failed", () async {
      final exception = Exception('Upload failed');
      when(mockProfileRemoteDataSource.editProfile(token, request)).thenAnswer((
          _) async => ApiFailedResult(exception.toString()));
      final result = await profileRepositoryImp.editProfile(token, request);
      expect(result, isA<ApiFailedResult<EditProfileResponsea>>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockProfileRemoteDataSource.editProfile(token, request)).called(1);
    });
  });
  group("Change Password Repositry Test", () {
    ChangePasswordRequest request = ChangePasswordRequest(
        password: "Mari123@",
        newPassword: "Mari123@1"
    );
    final successResponse = ChangePasswordResponse(
        message: "success",
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY"
    );
    test(
        "should return ApiSuccessResult when remote data source returns success",
            () async {
          when(mockProfileRemoteDataSource.changePassword(request, token))
              .thenAnswer((_) async => ApiSucessResult(successResponse));
          final result = await profileRepositoryImp.changePassword(
              request, token);
          expect(result, isA<ApiSucessResult<ChangePasswordResponse>>());
          expect((result as ApiSucessResult).sucessResult, successResponse);
          verify(mockProfileRemoteDataSource.changePassword(request, token))
              .called(1);
        });

    test("should return ApiFailedResult when remote data source returns Fails",
            () async {
          final failureResponse = ChangePasswordResponse(
              message: "Something went wrong");
          when(mockProfileRemoteDataSource.changePassword(request, token))
              .thenAnswer((_) async =>
              ApiFailedResult(failureResponse.message!));
          final result = await profileRepositoryImp.changePassword(
              request, token);
          expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
          expect((result as ApiFailedResult).errorMessage,
              failureResponse.message);
          verify(mockProfileRemoteDataSource.changePassword(request, token))
              .called(1);
        });
    test("should return ApiFailedResult on DioException", () async {
      final dioException = DioException(requestOptions: RequestOptions(
          path: ""
      ), type: DioExceptionType.connectionTimeout);
      when(mockProfileRemoteDataSource.changePassword(request, token)).
      thenAnswer((_) async =>
          ApiFailedResult(ServerFailure
              .fromDioError(dioException)
              .errorMessage));
      final result = await profileRepositoryImp.changePassword(request, token);
      expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage,
          "ServerFailure with Api Server");
      verify(mockProfileRemoteDataSource.changePassword(request, token))
          .called(1);
    });
  });
}