import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/edit_profile_response.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/response/upload_profile_photo_response.dart';
import 'package:flower_e_commerce/features/profile/data/repository/profile_repository_imp.dart';
import 'package:flower_e_commerce/features/profile/data/source/local/profile_local_data_source.dart';
import 'package:flower_e_commerce/features/profile/data/source/remote/profile_remote_data_source.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';

import 'profile_repository_imp_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource, ProfileLocalDataSource])
void main() {
  late ProfileRepositoryImp profileRepositoryImp;
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;
  late MockProfileLocalDataSource mockProfileLocalDataSource;
  late File photo;

  const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."; // dummy token

  setUpAll(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    profileRepositoryImp =
        ProfileRepositoryImp(mockProfileRemoteDataSource, mockProfileLocalDataSource);

    photo = File("/mock/path/to/file.jpg");

    // provideDummy for ApiResult
    provideDummy<ApiResult<UploadProfilePhotoResponse>>(
        ApiFailedResult<UploadProfilePhotoResponse>("Dummy Error"));
    provideDummy<ApiResult<EditProfileResponsea>>(
        ApiFailedResult<EditProfileResponsea>("Dummy Error"));
    provideDummy<ApiResult<ChangePasswordResponse>>(
        ApiFailedResult<ChangePasswordResponse>("Dummy Error"));

    // provideDummy for LocalDsResult
    provideDummy<LocalDsResult<List<GenericJsonSectionEntity>>>(
      LocalDsFailedResult<List<GenericJsonSectionEntity>>("Dummy Error"),
    );
  });

  /// -------------------- Upload Photo Tests --------------------
  group("Upload Photo Repository", () {
    final successResponse = UploadProfilePhotoResponse(message: "success");

    test("should return ApiSuccessResult when remote data source succeeds", () async {
      when(mockProfileRemoteDataSource.uploadPhoto(token, photo))
          .thenAnswer((_) async => ApiSucessResult(successResponse));

      final result = await profileRepositoryImp.uploadPhoto(token, photo);

      expect(result, isA<ApiSucessResult<UploadProfilePhotoResponse>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRemoteDataSource.uploadPhoto(token, photo)).called(1);
    });

    test("should return ApiFailedResult when remote data source fails", () async {
      final exception = Exception("Upload failed");
      when(mockProfileRemoteDataSource.uploadPhoto(token, photo))
          .thenAnswer((_) async => ApiFailedResult(exception.toString()));

      final result = await profileRepositoryImp.uploadPhoto(token, photo);

      expect(result, isA<ApiFailedResult<UploadProfilePhotoResponse>>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockProfileRemoteDataSource.uploadPhoto(token, photo)).called(1);
    });
  });

  /// -------------------- Edit Profile Tests --------------------
  group("Edit Profile Repository", () {
    final request = EditProfileRequest(
      firstName: "mariam",
      lastName: "Mohmed",
      email: "mariammohmed.25720@gmail.com",
      phone: "+201061728082",
    );

    final successResponse = EditProfileResponsea(
      message: "success",
      user: User(
        id: "68a21825a8bca307f9de9365",
        firstName: "mariam",
        lastName: "Mohmed",
        email: "mariammohmed.25720@gmail.com",
        password: "T8lSnOaFaPjq6q",
        gender: "female",
        phone: "+201061728082",
        photo: "https://flower.elevateegy.com/uploads/test.jpg",
        role: "user",
        wishlist: [],
        addresses: [],
        createdAt: "2025-08-17T17:57:57.084Z",
        passwordChangedAt: "2025-08-31T11:56:33.668Z",
      ),
    );

    test("should return ApiSuccessResult when remote data source succeeds", () async {
      when(mockProfileRemoteDataSource.editProfile(token, request))
          .thenAnswer((_) async => ApiSucessResult(successResponse));

      final result = await profileRepositoryImp.editProfile(token, request);

      expect(result, isA<ApiSucessResult<EditProfileResponsea>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRemoteDataSource.editProfile(token, request)).called(1);
    });

    test("should return ApiFailedResult when remote data source fails", () async {
      final exception = Exception("Edit failed");
      when(mockProfileRemoteDataSource.editProfile(token, request))
          .thenAnswer((_) async => ApiFailedResult(exception.toString()));

      final result = await profileRepositoryImp.editProfile(token, request);

      expect(result, isA<ApiFailedResult<EditProfileResponsea>>());
      expect((result as ApiFailedResult).errorMessage, exception.toString());
      verify(mockProfileRemoteDataSource.editProfile(token, request)).called(1);
    });
  });

  /// -------------------- Change Password Tests --------------------
  group("Change Password Repository", () {
    final request = ChangePasswordRequest(
      password: "Mari123@",
      newPassword: "Mari123@1",
    );

    final successResponse = ChangePasswordResponse(
      message: "success",
      token: "dummyToken",
    );

    test("should return ApiSuccessResult when remote data source succeeds", () async {
      when(mockProfileRemoteDataSource.changePassword(request, token))
          .thenAnswer((_) async => ApiSucessResult(successResponse));

      final result = await profileRepositoryImp.changePassword(request, token);

      expect(result, isA<ApiSucessResult<ChangePasswordResponse>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRemoteDataSource.changePassword(request, token)).called(1);
    });

    test("should return ApiFailedResult when remote data source fails", () async {
      final failureResponse = ChangePasswordResponse(message: "Something went wrong");
      when(mockProfileRemoteDataSource.changePassword(request, token))
          .thenAnswer((_) async => ApiFailedResult(failureResponse.message!));

      final result = await profileRepositoryImp.changePassword(request, token);

      expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage, failureResponse.message);
      verify(mockProfileRemoteDataSource.changePassword(request, token)).called(1);
    });

    test("should return ApiFailedResult on DioException", () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ""),
        type: DioExceptionType.connectionTimeout,
      );

      when(mockProfileRemoteDataSource.changePassword(request, token))
          .thenAnswer((_) async => ApiFailedResult(
          ServerFailure.fromDioError(dioException).errorMessage));

      final result = await profileRepositoryImp.changePassword(request, token);

      expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage,
          "ServerFailure with Api Server");
      verify(mockProfileRemoteDataSource.changePassword(request, token)).called(1);
    });
  });

  /// -------------------- Local Json Sections Tests --------------------
  group("ProfileRepositoryImp.getJsonSections", () {
    final jsonSectionEntity = GenericJsonSectionEntity(
      section: "about",
      title: {"en": "About", "ar": "عن التطبيق"},
      content: {"en": "App info", "ar": "معلومات التطبيق"},
      style: {
        "fontSize": 24,
        "fontWeight": "bold",
        "color": "#D21E6A",
        "textAlign": {"en": "center", "ar": "center"},
      },
    );

    test("should return LocalDsSucessResult when local data source succeeds", () async {
      when(mockProfileLocalDataSource.getJsonSections("jsonPath", "jsonKey"))
          .thenAnswer((_) async => LocalDsSucessResult([jsonSectionEntity]));

      final result = await profileRepositoryImp.getJsonSections("jsonPath", "jsonKey");

      expect(result, isA<LocalDsSucessResult<List<GenericJsonSectionEntity>>>());
      final success = result as LocalDsSucessResult<List<GenericJsonSectionEntity>>;
      expect(success.sucessResult.length, 1);
      expect(success.sucessResult.first.content, {
        "en": "App info",
        "ar": "معلومات التطبيق",
      });
      verify(mockProfileLocalDataSource.getJsonSections(any, any)).called(1);
    });

    test("should return LocalDsFailedResult when local data source fails", () async {
      when(mockProfileLocalDataSource.getJsonSections(any, any))
          .thenAnswer((_) async => LocalDsFailedResult("file not found"));

      final result = await profileRepositoryImp.getJsonSections("jsonPath", "jsonKey");

      expect(result, isA<LocalDsFailedResult<List<GenericJsonSectionEntity>>>());
      final fail = result as LocalDsFailedResult<List<GenericJsonSectionEntity>>;
      expect(fail.errorMessage, contains("file not found"));
      verify(mockProfileLocalDataSource.getJsonSections(any, any)).called(1);
    });
  });
}
