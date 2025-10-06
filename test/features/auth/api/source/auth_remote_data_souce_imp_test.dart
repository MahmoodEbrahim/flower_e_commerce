import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/auth/api/client/auth_api_service.dart';
import 'package:flower_e_commerce/features/auth/api/models/auth_response/auth_response_dto.dart';
import 'package:flower_e_commerce/features/auth/api/models/signup_request/signup_request_dto.dart';
import 'package:flower_e_commerce/features/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce/features/auth/api/source/auth_remote_data_souce_imp.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_souce_imp_test.mocks.dart';

@GenerateMocks([AuthApiService])
void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRemoteDataSourceImp authRemoteDataSouceImp;
  late SignupRequestModel fakeSignupRequestModel;
  late UserDto fakeUser;

  setUpAll(() {
    mockAuthApiService = MockAuthApiService();
    authRemoteDataSouceImp = AuthRemoteDataSourceImp(mockAuthApiService);

    fakeSignupRequestModel = SignupRequestModel(
      firstName: "Aya",
      lastName: "Saber",
      email: "aya.saber@example.com",
      password: "Ahmed@123",
      repassword: "Ahmed@123",
      phone: "+201234567890",
      gender: "female",
    );

    fakeUser = UserDto(
      id: "user_12345",
      firstName: "Aya",
      lastName: "Saber",
      email: "aya.saber@example.com",
      gender: "female",
      phone: "+201234567890",
      photo: "https://example.com/avatar.png",
      role: "customer",
      wishlist: ["prod_1", "prod_2", "prod_3"],
      addresses: [],
      createdAt: DateTime.now(),
    );
  });

  // -----------------------------sign up----------------------------------
  group("test signup function in the AuthRemoteDataSourceImp", () {
    test(
      "when call signup function with a correct parameters then it should return success api_result",
      () async {
        //------------------------Arrange----------------------------//
        AuthResponseDto fakeSignupResponseDto = AuthResponseDto(
          message: "sucess",
          user: fakeUser,
          token: "hhhhhhhhh",
        );

        when(
          mockAuthApiService.signUp(
            SignupRequestDto.toDto(fakeSignupRequestModel),
          ),
        ).thenAnswer((_) async => fakeSignupResponseDto);

        //----------------Act----------------------------------//
        final result = await authRemoteDataSouceImp.signUp(
          fakeSignupRequestModel,
        );

        //----------------Assert----------------------------------//
        verify(
          mockAuthApiService.signUp(
            SignupRequestDto.toDto(fakeSignupRequestModel),
          ),
        ).called(1);

        expect(result, isA<SucessResult<UserModel>>());
        final acResult = result as SucessResult<UserModel>;
        expect(acResult.sucessResult.email, fakeUser.email);
      },
    );

    test(
      "when call signup function with a correct parameters but there is dio exception then it should return failed api_result",
      () async {
        //------------------------Arrange----------------------------//
        final String dioExceptionMessage = "dio error";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioExceptionMessage,
        );

        when(
          mockAuthApiService.signUp(
            SignupRequestDto.toDto(fakeSignupRequestModel),
          ),
        ).thenThrow(mockDioException);

        //----------------Act----------------------------------//
        final result = await authRemoteDataSouceImp.signUp(
          fakeSignupRequestModel,
        );

        //----------------Assert----------------------------------//
        verify(mockAuthApiService.signUp(any)).called(1);

        expect(result, isA<FailedResult<UserModel>>());
        final FailedResult<UserModel> acResult =
            result as FailedResult<UserModel>;
        expect(acResult.errorMessage, equals(dioExceptionMessage));
      },
    );

    test(
      "when call signup function with a correct parameters but there is exception then it should return failed api_result",
      () async {
        //------------------------Arrange----------------------------//
        final String exceptionMessage = "exception error";
        final Exception mockException = Exception(exceptionMessage);

        when(
          mockAuthApiService.signUp(
            SignupRequestDto.toDto(fakeSignupRequestModel),
          ),
        ).thenThrow(mockException);

        //----------------Act----------------------------------//
        final result = await authRemoteDataSouceImp.signUp(
          fakeSignupRequestModel,
        );

        //----------------Assert----------------------------------//
        verify(mockAuthApiService.signUp(any)).called(1);

        expect(result, isA<FailedResult<UserModel>>());
        final FailedResult<UserModel> acResult =
            result as FailedResult<UserModel>;
        expect(acResult.errorMessage, equals(mockException.toString()));
      },
    );
  });

  // -----------------------------login----------------------------------
  group('AuthRemoteDataSource.login', () {
    const email = "test@test.com";
    const password = "123456";

    test('should return ApiSuccessResult when login is successful', () async {
      // Arrange
      final fakeLoginResponse = AuthResponseDto(
        token: "fake_token",
        user: UserDto(
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
        ),
      );

      when(
        mockAuthApiService.logIn(any),
      ).thenAnswer((_) async => fakeLoginResponse);

      // Act
      final result = await authRemoteDataSouceImp.login(email, password);
      final success = result as SucessResult<LoginModel>;

      // Assert
      expect(result, isA<SucessResult<LoginModel>>());
      expect(success.sucessResult.token, "fake_token");
      expect(success.sucessResult.user.email, email);
    });

    test('should return ApiErrorResult when DioException is thrown', () async {
      // Arrange
      when(
        mockAuthApiService.logIn(any),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      // Act
      final result = await authRemoteDataSouceImp.login(email, password);

      // Assert
      expect(result, isA<FailedResult<LoginModel>>());
    });

    test(
      'should return ApiErrorResult when other Exception is thrown',
      () async {
        // Arrange
        when(
          mockAuthApiService.logIn(any),
        ).thenThrow(Exception("Unknown Error"));

        // Act
        final result = await authRemoteDataSouceImp.login(email, password);
        final error = result as FailedResult<LoginModel>;

        // Assert
        expect(result, isA<FailedResult<LoginModel>>());
        expect(error.errorMessage, contains("Unknown Error"));
      },
    );
  });
}
