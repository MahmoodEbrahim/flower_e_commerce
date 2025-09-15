import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart' as utils;
import 'package:flower_e_commerce/features/auth/data/repository/auth_repository_imp.dart';
import 'package:flower_e_commerce/features/auth/data/source/auth_remote_data_source.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_imp_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImp authRepositoryImp;
  late SignupRequestModel fakeSignupRequestModel;
  late UserModel fakeUser;

  setUpAll(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImp = AuthRepositoryImp(mockAuthRemoteDataSource);

    fakeSignupRequestModel = SignupRequestModel(
      firstName: "Aya",
      lastName: "Saber",
      email: "aya.saber@example.com",
      password: "Ahmed@123",
      repassword: "Ahmed@123",
      phone: "+201234567890",
      gender: "female",
    );

    fakeUser = UserModel(
      firstName: "Aya",
      lastName: "Saber",
      email: "aya.saber@example.com",
      gender: "female",
      phone: "+201234567890",
      photo: "https://example.com/avatar.png",
      role: "customer",
      wishlist: ["prod_1", "prod_2", "prod_3"],
      addresses: [],
    );

    provideDummy<ApiResult<UserModel>>(ApiFailedResult<UserModel>("dummy"));
    provideDummy<utils.ApiResult<LoginModel>>(
        utils.ApiFailedResult<LoginModel>("dummy"));
  });

  // ---------------------------signup------------------------------------
  group("test signup in AuthRepository", () {
    test(
        'when call signUp in AuthRepositoryImp with success paramters it should create user from AuthRemoteDataSource with successApiResult',
            () async {
          //Arrange
          final mockResult = ApiSucessResult<UserModel>(fakeUser);
          provideDummy<ApiResult<UserModel>>(mockResult);

          when(mockAuthRemoteDataSource.signUp(fakeSignupRequestModel))
              .thenAnswer((_) async => mockResult);

          //Act
          final result = await authRepositoryImp.signUp(fakeSignupRequestModel);

          // Assert
          expect(result, isA<ApiSucessResult<UserModel>>());
          final acResult = result as ApiSucessResult<UserModel>;
          expect(acResult.sucessResult.firstName, equals("Aya"));
          expect(acResult.sucessResult.email, equals("aya.saber@example.com"));

          verify(mockAuthRemoteDataSource.signUp(fakeSignupRequestModel)).called(1);
        });

    test(
        'when call signUp in AuthRepositoryImp  it should return failedApiResult',
            () async {
          //Arrange
          final mockResult = ApiFailedResult<UserModel>("failed");
          provideDummy<ApiResult<UserModel>>(mockResult);

          when(mockAuthRemoteDataSource.signUp(fakeSignupRequestModel))
              .thenAnswer((_) async => mockResult);

          //Act
          final result = await authRepositoryImp.signUp(fakeSignupRequestModel);

          // Assert
          expect(result, isA<ApiFailedResult<UserModel>>());
          final acResult = result as ApiFailedResult<UserModel>;
          expect(acResult.errorMessage, equals("failed"));

          verify(mockAuthRemoteDataSource.signUp(fakeSignupRequestModel)).called(1);
        });
  });

  // -----------------------------log in----------------------------------
  group("test AuthRepositoryImp.login", () {
    test("should return ApiSuccessResult when login is successful", () async {
      //arrange
      const email = "test@test.com";
      const password = "123456";

      LoginModel fakeLoginEntity = LoginModel(
        token: "fake_token",
        user: UserModel(
          iid: "1",
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

      when(mockAuthRemoteDataSource.login(email, password)).thenAnswer(
            (_) async => utils.ApiSucessResult<LoginModel>(fakeLoginEntity),
      );

      //act
      final result = await authRepositoryImp.login(email, password);
      final success = result as ApiSucessResult<LoginModel>;

      //assert
      expect(result, isA<ApiSucessResult<LoginModel>>());
      expect(success.sucessResult.token, "fake_token");
      expect(success.sucessResult.user.email, email);
    });

    test("should return ApiFailedResult when login fails", () async {
      //arrange
      const email = "test@test.com";
      const password = "123456";

      when(mockAuthRemoteDataSource.login(email, password)).thenAnswer(
            (_) async => utils.ApiFailedResult<LoginModel>("errorMessage"),
      );

      //act
      final result = await authRepositoryImp.login(email, password);
      final error = result as utils.ApiFailedResult<LoginModel>;

      //assert
      expect(result, isA<utils.ApiFailedResult<LoginModel>>());
      expect(error.errorMessage, "errorMessage");
    });
  });
}
