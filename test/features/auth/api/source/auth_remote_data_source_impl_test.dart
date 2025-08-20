import 'package:dio/dio.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/api/source/auth_remote_data_souce_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/core/utils/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/responses/login_response.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_entity.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiService])
void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRemoteDataSourceImp dataSource;

  setUpAll(() {
    mockAuthApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImp(mockAuthApiService);
  });

  group('AuthRemoteDataSource.login', () {
    const email = "test@test.com";
    const password = "123456";

    test('should return ApiSuccessResult when login is successful', () async {
      // Arrange
      final fakeLoginResponse = LoginResponse(
        token: "fake_token",
        user: UserDTO(
          id: "1",
          firstName: "Test",
          lastName: "User",
          email: email,
          gender: "female",
          phone: "0123456789",
          photo: null,
          role: "customer",
          wishlist: [],
          addresses: [],
          createdAt: "2025-08-20",
        ),
      );

      when(mockAuthApiService.logIn(any))
          .thenAnswer((_) async => fakeLoginResponse);

      // Act
      final result = await dataSource.login(email, password);
      final success = result as ApiSuccessResult<LoginEntity>;

      // Assert
      expect(result, isA<ApiSuccessResult<LoginEntity>>());
      expect(success.data.token, "fake_token");
      expect(success.data.user.email, email);
    });

    test('should return ApiErrorResult when DioException is thrown', () async {
      // Arrange
      when(mockAuthApiService.logIn(any))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.login(email, password);

      // Assert
      expect(result, isA<ApiErrorResult<LoginEntity>>());
    });

    test('should return ApiErrorResult when other Exception is thrown', () async {
      // Arrange
      when(mockAuthApiService.logIn(any))
          .thenThrow(Exception("Unknown Error"));

      // Act
      final result = await dataSource.login(email, password);
      final error = result as ApiErrorResult<LoginEntity>;

      // Assert
      expect(result, isA<ApiErrorResult<LoginEntity>>());
      expect(error.errorMessage, contains("Unknown Error"));
    });
  });
}
