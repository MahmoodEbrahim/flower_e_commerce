import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/response/change_password_response.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/get_change_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_change_password_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])

void main() {
  late GetChangePasswordUseCase getChangePasswordUseCase;
  late MockProfileRepository mockProfileRepository;
  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getChangePasswordUseCase = GetChangePasswordUseCase(mockProfileRepository);
    provideDummy<ApiResult<ChangePasswordResponse>>(
        ApiFailedResult<ChangePasswordResponse>("Dummy Error")
    );
  });
  group("Change Password UseCase Test", () {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY";
    ChangePasswordRequest request = ChangePasswordRequest(
        password: "Mari123@",
        newPassword: "Mari123@1"
    );
    final successResponse = ChangePasswordResponse(
        message: "success",
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTY1NjU5MDh9.SG6OMFWYluNn__hIfstJXPbT00zoPlMEghSDGvdTkSY"
    );
    test("return ApiSuccessResult when  ProfileRepository success", () async {
      when(mockProfileRepository.changePassword(request, token)).
      thenAnswer((_) async => ApiSucessResult(successResponse));
      final result = await getChangePasswordUseCase.changePassword(
          request, token);
      expect(result, isA<ApiSucessResult<ChangePasswordResponse>>());
      expect((result as ApiSucessResult).sucessResult, successResponse);
      verify(mockProfileRepository.changePassword(request, token)).called(1);
    });
    test("return ApiFailedResult when  ProfileRepository fails", () async {
      final failureResponse = ChangePasswordResponse(
        message: "Something went wrong",

      );
      when(mockProfileRepository.changePassword(request, token)).thenAnswer((
          _) async =>
          ApiFailedResult(failureResponse.message!));
      final result = await getChangePasswordUseCase.changePassword(
          request, token);
      expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage, failureResponse.message);
      verify(mockProfileRepository.changePassword(request, token)).called(1);
    });
    test("return ApiFailedResult when  ProfileRepository fails", () async {
      final dioException = DioException(requestOptions: RequestOptions(
        path: "",

      ), type: DioExceptionType.connectionTimeout);
      when(mockProfileRepository.changePassword(request, token)).thenAnswer((
          _) async =>
          ApiFailedResult(ServerFailure
              .fromDioError(dioException)
              .errorMessage));

      final result = await getChangePasswordUseCase.changePassword(
          request, token);
      expect(result, isA<ApiFailedResult<ChangePasswordResponse>>());
      expect((result as ApiFailedResult).errorMessage,
          "ServerFailure with Api Server");
      verify(mockProfileRepository.changePassword(request, token)).called(1);
    });
  });
}